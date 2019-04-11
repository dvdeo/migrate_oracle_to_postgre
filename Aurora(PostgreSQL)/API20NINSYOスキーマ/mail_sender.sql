CREATE OR REPLACE FUNCTION api20ninsyo.mail_sender(IN i_from TEXT, IN i_to TEXT, IN i_subject TEXT, IN i_message TEXT, OUT rtncd DOUBLE PRECISION, IN i_cc TEXT DEFAULT NULL, IN i_enc TEXT DEFAULT 'JA16SJIS', IN i_enc_h TEXT DEFAULT 'Shift-JIS')
AS
$BODY$
/* ワーク変数 */
/* smtp_adrs     varchar2(100)   := '172.24.200.220'; */
DECLARE
    aws_oracle_ext$array_id$temporary BIGINT;
    smtp_adrs CHARACTER VARYING(100) := '172.28.196.7';
    smtp_port CHARACTER VARYING(10) := '25';
    cr_lf CONSTANT CHARACTER VARYING(2) := CONCAT_WS('', CHR(13), CHR(10));
    tab CONSTANT CHARACTER VARYING(2) := CHR(9);
    token CHARACTER VARYING(256) := NULL;
    s_pos DOUBLE PRECISION;
    e_pos DOUBLE PRECISION;
    address CHARACTER VARYING(256);
    name CHARACTER VARYING(256)
    /* SMTPコネクション */;
    conn aws_oracle_ext.utl_smtp$connection;
    to_list VARCHAR(100) := 'to_list';
    cc_list VARCHAR(100) := 'cc_list';
    title_maxlen DOUBLE PRECISION := 50
    /* 60文字ずつ切る */;
    len DOUBLE PRECISION;
    i DOUBLE PRECISION;
    w_message CHARACTER VARYING(4000);
    signature CHARACTER VARYING(256) := CONCAT_WS('', '--', cr_lf, 'This message may contain confidential information.', cr_lf, 'If you are not the designated recipient, please notify the sender immediately,', cr_lf, 'and delete the original and any copies. Any use of the message by you is prohibited.', cr_lf, 'Thank you.');
    subject_buffer CHARACTER VARYING(1024);
    subject_heder CHARACTER VARYING(128);
    cpy_start DOUBLE PRECISION;
    cpy_end DOUBLE PRECISION;
/* SMTP接続 */
BEGIN
    aws_oracle_ext$array_id$temporary := aws_oracle_ext.array$create_array('to_list', 'api20ninsyo.mail_sender');
    PERFORM aws_oracle_ext.array$add_fields_to_array(aws_oracle_ext$array_id$temporary, '[{"":"CHARACTER VARYING(256)"}]');
    aws_oracle_ext$array_id$temporary := aws_oracle_ext.array$create_array('cc_list', 'api20ninsyo.mail_sender');
    PERFORM aws_oracle_ext.array$add_fields_to_array(aws_oracle_ext$array_id$temporary, '[{"":"CHARACTER VARYING(256)"}]');
    conn := aws_oracle_ext.utl_smtp$open_connection(smtp_adrs, smtp_port)
    /* 接続後の初期応答 */;
    PERFORM aws_oracle_ext.utl_smtp$helo(conn, smtp_adrs)
    /* 発信元メールアドレスを設定 */;
    PERFORM aws_oracle_ext.utl_smtp$mail(conn, i_from)
    /* 送信先メールアドレスを設定 */;
    s_pos := 1;
    e_pos := 0;

    LOOP
        e_pos := aws_oracle_ext.INSTR(i_to, ',', TRUNC(s_pos::NUMERIC)::INTEGER);

        IF e_pos = 0 THEN
            token := aws_oracle_ext.substr(i_to, s_pos, LENGTH(i_to));
        ELSE
            token := aws_oracle_ext.substr(i_to, s_pos, e_pos - s_pos);
        END IF;
        PERFORM aws_oracle_ext.utl_smtp$rcpt(conn, token);
        PERFORM aws_oracle_ext.array$set_value('to_list[' || aws_oracle_ext.array$count('to_list', 'api20ninsyo.mail_sender') + 1 || ']', 'api20ninsyo.mail_sender', token);
        s_pos := e_pos + 1;
        EXIT WHEN e_pos = 0;
    END LOOP
    /* CCメールアドレスを設定 */;

    IF i_cc IS NOT NULL THEN
        s_pos := 1;
        e_pos := 0;

        LOOP
            e_pos := aws_oracle_ext.INSTR(i_cc, ',', TRUNC(s_pos::NUMERIC)::INTEGER);

            IF e_pos = 0 THEN
                token := aws_oracle_ext.substr(i_cc, s_pos, LENGTH(i_cc));
            ELSE
                token := aws_oracle_ext.substr(i_cc, s_pos, e_pos - s_pos);
            END IF;
            PERFORM aws_oracle_ext.utl_smtp$rcpt(conn, token);
            PERFORM aws_oracle_ext.array$set_value('cc_list[' || aws_oracle_ext.array$count('cc_list', 'api20ninsyo.mail_sender') + 1 || ']', 'api20ninsyo.mail_sender', token);
            s_pos := e_pos + 1;
            EXIT WHEN e_pos = 0;
        END LOOP;
    END IF
    /* 送信メールオープン */;
    PERFORM aws_oracle_ext.utl_smtp$open_data(conn)
    /* メールヘッダ、本文を設定 */
    /* */
    /* TO */
    /* */;
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, 'To: ');

    FOR i IN 1..aws_oracle_ext.array$count('to_list', 'api20ninsyo.mail_sender') LOOP
        name := aws_oracle_ext.regexp_replace(aws_oracle_ext.array$get_value('to_list[' || i || ']', 'api20ninsyo.mail_sender', NULL::CHARACTER VARYING(256)), E'\\s<.*>|<.*>');
        address := aws_oracle_ext.regexp_replace(aws_oracle_ext.array$get_value('to_list[' || i || ']', 'api20ninsyo.mail_sender', NULL::CHARACTER VARYING(256)), '^.*<|>$');

        IF i != 1 THEN
            PERFORM aws_oracle_ext.utl_smtp$write_data(conn, ', ');
        END IF;
        PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', '=?', i_enc_h, '?B?'))
        /*
        [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.CONVERT(VARCHAR2,VARCHAR2) function. Use suitable function or create user defined function.]
        UTL_SMTP.write_raw_data(conn,
                        utl_encode.base64_encode(
                                utl_raw.cast_to_raw(convert(name, i_enc))
                ))
        */;
        PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', '?=<', address, '>'));
    END LOOP;
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, cr_lf)
    /* */
    /* CC */
    /* */;

    IF i_cc IS NOT NULL THEN
        PERFORM aws_oracle_ext.utl_smtp$write_data(conn, 'CC: ');

        FOR i IN 1..aws_oracle_ext.array$count('cc_list', 'api20ninsyo.mail_sender') LOOP
            name := aws_oracle_ext.regexp_replace(aws_oracle_ext.array$get_value('cc_list[' || i || ']', 'api20ninsyo.mail_sender', NULL::CHARACTER VARYING(256)), E'\\s<.*>|<.*>');
            address := aws_oracle_ext.regexp_replace(aws_oracle_ext.array$get_value('cc_list[' || i || ']', 'api20ninsyo.mail_sender', NULL::CHARACTER VARYING(256)), '^.*<|>$');

            IF i != 1 THEN
                PERFORM aws_oracle_ext.utl_smtp$write_data(conn, ', ');
            END IF;
            PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', '=?', i_enc_h, '?B?'))
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.CONVERT(VARCHAR2,VARCHAR2) function. Use suitable function or create user defined function.]
            UTL_SMTP.write_raw_data(conn,
                                    utl_encode.base64_encode(
                                            utl_raw.cast_to_raw(convert(name, i_enc))
                            ))
            */;
            PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', '?=<', address, '>'));
        END LOOP;
        PERFORM aws_oracle_ext.utl_smtp$write_data(conn, cr_lf);
    END IF
    /* */
    /* From */
    /* */;
    name := aws_oracle_ext.regexp_replace(i_from, E'\\s<.*>|<.*>');
    address := aws_oracle_ext.regexp_replace(i_from, '^.*<|>$');
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', 'From:=?', i_enc_h, '?B?'))
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.CONVERT(VARCHAR2,VARCHAR2) function. Use suitable function or create user defined function.]
    UTL_SMTP.write_raw_data(conn,
        utl_encode.base64_encode(
              utl_raw.cast_to_raw(convert(name, i_enc))
        ))
    */;
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', '?=<', address, '>', cr_lf))
    /* */
    /* Subject */
    /* */;
    subject_buffer := '';
    cpy_start := 1;
    subject_heder := 'Subject:';
    title_maxlen := 10;

    FOR cpy_end IN 1..LENGTH(i_subject) LOOP
        /*
        [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.CONVERT(VARCHAR2,VARCHAR2) function. Use suitable function or create user defined function.]
        subject_buffer := utl_encode.base64_encode(
        			                utl_raw.cast_to_raw(
                                		convert(substr(i_subject, cpy_start, cpy_end -cpy_start +1), i_enc)
        						))
        */
        /* 76バイトを超えた場合、前回に変換した分を出力し、改行処理 */
        IF octet_length(subject_buffer) >= title_maxlen THEN
            PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', subject_heder, '=?', i_enc_h, '?B?'));
            PERFORM aws_oracle_ext.utl_smtp$write_raw_data(conn, subject_buffer);
            PERFORM aws_oracle_ext.utl_smtp$write_data(conn, '?=');
            PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', cr_lf, tab));
            subject_buffer := NULL;
            subject_heder := '';
            cpy_start := cpy_end + 1;
        END IF;
    END LOOP;

    IF subject_buffer IS NOT NULL THEN
        PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', '=?', i_enc_h, '?B?'));
        PERFORM aws_oracle_ext.utl_smtp$write_raw_data(conn, subject_buffer);
        PERFORM aws_oracle_ext.utl_smtp$write_data(conn, '?=');
    END IF;
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, cr_lf)
    /* */
    /* Message */
    /* */;
    w_message := CONCAT_WS('', i_message, cr_lf, signature);
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', 'MIME-Version: 1.0', cr_lf));
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', 'Content-Type: text/plain; charset=', i_enc_h, cr_lf));
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, CONCAT_WS('', 'Content-Transfer-Encoding: base64', cr_lf));
    PERFORM aws_oracle_ext.utl_smtp$write_data(conn, cr_lf)
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.CONVERT(VARCHAR2,VARCHAR2) function. Use suitable function or create user defined function.]
    UTL_SMTP.write_raw_data(conn,
        utl_encode.base64_encode(
              utl_raw.cast_to_raw(convert(replace(w_message,chr(10),cr_lf), i_enc))
        ))
    */
    /* 送信メールクローズ */;
    PERFORM aws_oracle_ext.utl_smtp$close_data(conn)
    /* SMTP接続終了 */;
    PERFORM aws_oracle_ext.utl_smtp$quit(conn)
    /* リターンコードセット */;
    rtncd := 0;
    PERFORM aws_oracle_ext.array$clear_procedure('api20ninsyo.mail_sender');
    EXCEPTION
        WHEN others THEN
            rtncd := 9;
END;
$BODY$
LANGUAGE  plpgsql;