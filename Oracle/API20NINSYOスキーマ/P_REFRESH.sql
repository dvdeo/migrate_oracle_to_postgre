CREATE OR REPLACE PROCEDURE "API20NINSYO".P_REFRESH (
  i_mview    in  varchar2,  -- マテリアライズド・ビュー名
  rtncd      out  char    -- リターンコード
            --   0000：正常終了
            --   0099：異常終了
) is
  cursor pubdb_cur is
    select db_link from pubdb_tbl where deliver_flg = 1 order by db_link;

  -- ワーク変数
  w_rtncd    char(4);
  exec_sql    varchar2(100);
  mail_to    varchar2(100);
  mail_from    varchar2(100);
  mail_msg    varchar2(1000);
begin
  w_rtncd := '0000'  ;
  for pubdb_rec in pubdb_cur loop
    begin
      exec_sql := 'begin dbms_mview.refresh@' || pubdb_rec.db_link || '(''' || i_mview || '''); end;';
      execute immediate exec_sql;
    exception
      when others then
        -- メールアドレス取得
        select to_maddr, from_maddr
          into mail_to, mail_from
          from mail_addr_tbl
          where kubun = 'DB';

        -- メール文章作成
        mail_msg := '';
        mail_msg := mail_msg || '-- マテリアライズド・ビュー リフレッシュ処理エラー通知メール --' || chr(10);
        mail_msg := mail_msg || chr(10);
        mail_msg := mail_msg || 'ビュー名称：' || i_mview || chr(10);
        mail_msg := mail_msg || 'ターゲット：' || pubdb_rec.db_link || chr(10);
        mail_msg := mail_msg || 'エラー内容：' || substr(sqlerrm,1,200) || chr(10);
        mail_msg := mail_msg || chr(10);
        mail_msg := mail_msg || '-----------------------------------------------------' || chr(10);
        mail_msg := mail_msg || 'マテリアライズド・ビュー リフレッシュ処理プロシージャ' || chr(10);

        -- メール送信
      mail_sender(
        i_from => mail_from,
        i_to => mail_to,
        i_subject => 'マテリアライズド・ビュー リフレッシュ処理エラー',
        i_message => mail_msg,
        rtncd => rtncd
      );
        w_rtncd := '0099';
    end;
  end loop;
  rtncd := w_rtncd;
exception
  when others then
    -- メールアドレス取得
    select to_maddr, from_maddr
      into mail_to, mail_from
      from mail_addr_tbl
      where kubun = 'DB';

    -- メール文章作成
    mail_msg := '';
    mail_msg := mail_msg || '-- マテリアライズド・ビュー リフレッシュ処理エラー通知メール --' || chr(10);
    mail_msg := mail_msg || chr(10);
    mail_msg := mail_msg || 'ビュー名称：' || i_mview || chr(10);
    mail_msg := mail_msg || 'エラー内容：' || substr(sqlerrm,1,200) || chr(10);
    mail_msg := mail_msg || chr(10);
    mail_msg := mail_msg || '-----------------------------------------------------' || chr(10);
    mail_msg := mail_msg || 'マテリアライズド・ビュー リフレッシュ処理プロシージャ' || chr(10);

  -- メール送信
    mail_sender(
        i_from => mail_from,
        i_to => mail_to,
        i_subject => 'マテリアライズド・ビュー リフレッシュ処理エラー',
        i_message => mail_msg,
        rtncd => rtncd
    );

    rtncd := '0099';
end;