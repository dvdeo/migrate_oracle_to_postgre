CREATE OR REPLACE PROCEDURE "API20NINSYO".mail_sender(
  i_from        in      varchar2,                               -- 送信元メールアドレス
  i_to          in      varchar2,                               -- 送信先メールアドレス
  i_subject     in      varchar2,                               -- サブジェクト
  i_message     in      varchar2,                               -- 本文
  rtncd         out     number,                                 -- リターンコード
  i_cc          in      varchar2 := null,               -- CCメールアドレス
  i_enc         in      varchar2 := 'JA16SJIS',     -- 文字コード
  i_enc_h       in      varchar2 := 'Shift-JIS' -- 文字コード(表示用)

) as

  -- ワーク変数
--  smtp_adrs     varchar2(100)   := '172.24.200.220';
  smtp_adrs     varchar2(100)   := '172.28.196.7';
  smtp_port     varchar2(10)    := '25';

  cr_lf         constant varchar2(2) := chr(13) || chr(10);
  tab           constant varchar2(2) := chr(9);

  token         varchar2(256)    := null;
  s_pos         number;
  e_pos         number;

  address       varchar2(256);
  name          varchar2(256);

  -- SMTPコネクション
  conn  UTL_SMTP.connection;

  TYPE address_tab IS TABLE OF VARCHAR2(256) INDEX BY PLS_INTEGER;
  to_list address_tab;
  cc_list address_tab;

  title_maxlen number := 50; -- 60文字ずつ切る
  len number;
  i number;

  w_message     varchar2(4000);
  signature     varchar2(256)   := '--'||cr_lf||
                                    'This message may contain confidential information.'||cr_lf||
                                    'If you are not the designated recipient, please notify the sender immediately,'||cr_lf||
                                    'and delete the original and any copies. Any use of the message by you is prohibited.'||cr_lf||
                                    'Thank you.';

  subject_buffer varchar2(1024);
  subject_heder  varchar2(128);
  cpy_start number;
  cpy_end	number;

begin
  -- SMTP接続
  conn := UTL_SMTP.open_connection(smtp_adrs, smtp_port);

  -- 接続後の初期応答
  UTL_SMTP.helo(conn, smtp_adrs);

  -- 発信元メールアドレスを設定
  UTL_SMTP.mail(conn, i_from);

  -- 送信先メールアドレスを設定
  s_pos := 1;
  e_pos := 0;
  LOOP
        e_pos := INSTR(i_to, ',', s_pos);
        IF e_pos = 0 THEN
                token := SUBSTR(i_to, s_pos, LENGTH(i_to));
        ELSE
                token := SUBSTR(i_to, s_pos, e_pos -s_pos);
        END IF;

        UTL_SMTP.rcpt(conn, token);
        to_list(to_list.COUNT +1) := token;

        s_pos := e_pos +1;
        EXIT WHEN e_pos = 0;
  END LOOP;

  -- CCメールアドレスを設定
  IF i_cc is not null THEN
          s_pos := 1;
          e_pos := 0;
          LOOP
                e_pos := INSTR(i_cc, ',', s_pos);
                IF e_pos = 0 THEN
                        token := SUBSTR(i_cc, s_pos, LENGTH(i_cc));
                ELSE
                        token := SUBSTR(i_cc, s_pos, e_pos -s_pos);
                END IF;

                UTL_SMTP.rcpt(conn, token);
                cc_list(cc_list.COUNT +1) := token;

                s_pos := e_pos +1;
                EXIT WHEN e_pos = 0;
          END LOOP;
  END IF;

  -- 送信メールオープン
  UTL_SMTP.open_data(conn);

  -- メールヘッダ、本文を設定

  --
  -- TO
  --
  UTL_SMTP.write_data(conn, 'To: ');
  FOR i IN 1..to_list.COUNT LOOP
        name    := REGEXP_REPLACE(to_list(i) ,'\s<.*>|<.*>');
        address := REGEXP_REPLACE(to_list(i),'^.*<|>$');

        IF i != 1 THEN
                UTL_SMTP.write_data(conn, ', ');
        END IF;

        UTL_SMTP.write_data(conn, '=?' || i_enc_h || '?B?');
        UTL_SMTP.write_raw_data(conn,
                utl_encode.base64_encode(
                        utl_raw.cast_to_raw(convert(name, i_enc))
        ));
        UTL_SMTP.write_data(conn, '?=<' || address || '>');
  END LOOP;
  UTL_SMTP.write_data(conn, cr_lf);

  --
  -- CC
  --
  IF i_cc is not null THEN
          UTL_SMTP.write_data(conn, 'CC: ');
          FOR i IN 1..cc_list.COUNT LOOP
                name    := REGEXP_REPLACE(cc_list(i) ,'\s<.*>|<.*>');
                address := REGEXP_REPLACE(cc_list(i),'^.*<|>$');

                IF i != 1 THEN
                        UTL_SMTP.write_data(conn, ', ');
                END IF;

                UTL_SMTP.write_data(conn, '=?' || i_enc_h || '?B?');
                UTL_SMTP.write_raw_data(conn,
                        utl_encode.base64_encode(
                                utl_raw.cast_to_raw(convert(name, i_enc))
                ));
                UTL_SMTP.write_data(conn, '?=<' || address || '>');
          END LOOP;
          UTL_SMTP.write_data(conn, cr_lf);
  END IF;

  --
  -- From
  --
  name  := REGEXP_REPLACE(i_from ,'\s<.*>|<.*>');
  address := REGEXP_REPLACE(i_from ,'^.*<|>$');

  UTL_SMTP.write_data(conn, 'From:=?' || i_enc_h || '?B?');
  UTL_SMTP.write_raw_data(conn,
    utl_encode.base64_encode(
          utl_raw.cast_to_raw(convert(name, i_enc))
    ));
  UTL_SMTP.write_data(conn, '?=<' || address || '>' || cr_lf);


  --
  -- Subject
  --
  subject_buffer := '';
  cpy_start := 1;
  subject_heder := 'Subject:';
  title_maxlen := 10;

  FOR cpy_end in 1..length(i_subject) LOOP
	subject_buffer := utl_encode.base64_encode(
			                utl_raw.cast_to_raw(
                        		convert(substr(i_subject, cpy_start, cpy_end -cpy_start +1), i_enc)
						));

	-- 76バイトを超えた場合、前回に変換した分を出力し、改行処理
	IF utl_raw.length(subject_buffer) >= title_maxlen THEN

		UTL_SMTP.write_data(conn, subject_heder || '=?'||i_enc_h||'?B?');

  		UTL_SMTP.write_raw_data(conn, subject_buffer);
        UTL_SMTP.write_data(conn, '?=');
		utl_smtp.write_data(conn, cr_lf||tab);

  		subject_buffer := null;
		subject_heder  := '';
		cpy_start := cpy_end +1;
	END IF;

  END LOOP;
  IF subject_buffer is not null THEN
	UTL_SMTP.write_data(conn, '=?'||i_enc_h||'?B?');
  	UTL_SMTP.write_raw_data(conn, subject_buffer);
	UTL_SMTP.write_data(conn, '?=');
  END IF;
  UTL_SMTP.write_data(conn, cr_lf);

  --
  -- Message
  --
  w_message := i_message||cr_lf||signature;
  UTL_SMTP.write_data(conn, 'MIME-Version: 1.0' || cr_lf);
  UTL_SMTP.write_data(conn, 'Content-Type: text/plain; charset=' || i_enc_h || cr_lf);
  UTL_SMTP.write_data(conn, 'Content-Transfer-Encoding: base64' || cr_lf);
  UTL_SMTP.write_data(conn, cr_lf);
  UTL_SMTP.write_raw_data(conn,
    utl_encode.base64_encode(
          utl_raw.cast_to_raw(convert(replace(w_message,chr(10),cr_lf), i_enc))
    ));

  -- 送信メールクローズ
  UTL_SMTP.close_data(conn);

  -- SMTP接続終了
  UTL_SMTP.quit(conn);
  --リターンコードセット
  rtncd := 0;

exception
  when others then
    rtncd := 9;

end;