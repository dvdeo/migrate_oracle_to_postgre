CREATE OR REPLACE PROCEDURE "API20NINSYO".P_API20_END_MAIL(
  i_yymmdd in  date,  -- 日付
  rtncd    out number -- リターンコード
) is

  -- API企業マスタカーソル
  cursor api_corp_cur(i_yymmdd in date) is
    select c.cid,
           c.cname,
           to_char(c.s_date,'yyyy/mm/dd') || ' - ' || to_char(c.e_date,'yyyy/mm/dd') use_kikan,
           c.e_date,
           z.usermei,
           z.maddr,
           replace(c.other_maddr,'\','') other_maddr
    from api20_corp_mst c , zdc_uid z
    where c.sales_id = z.userid
    and   c.end_flg = '0'
    and   c.e_date <= i_yymmdd ;

  -- ワーク変数
  mail_msg     varchar2(2000);
  mail_subject varchar2(2000);
  mail_to      varchar2(1000);
  mail_cc      varchar2(1000);
  mail_from    varchar2(100);

  wk_mail_to   varchar2(1000);
  wk_mail_cc   varchar2(1000);
  wk_mail_from varchar2(100);
begin
  -- メールアドレス取得
  select to_maddr, to_maddr, from_maddr
  into wk_mail_to, wk_mail_cc,wk_mail_from
  from mail_addr_tbl
  where kubun = 'BO';

  -- 企業カーソルオープン
  for api_corp_rec in api_corp_cur(i_yymmdd) loop
    mail_to := wk_mail_to;
    mail_cc := wk_mail_cc;
    mail_from := wk_mail_from;

    --ZDC_UIDにメールアドレスが設定されていればソレを優先
    --なければ、MAIL_ADDR_TBLの区分'BO'のメールアドレスを使用
    --さらに、API_CORP_MAILに関係者メールアドレスレコードが存在すれば、ソレも結合
    --ZDC_UIDにメールアドレスが設定されている場合に限り、CCとしてMAIL_ADDR_TBLの区分'BO'のメールアドレスを設定する
    --何も設定がない場合は、MAIL_ADDR_TBLの区分'BO'宛にメールする
    if api_corp_rec.maddr is not null and api_corp_rec.other_maddr is null then
      mail_to := api_corp_rec.maddr;
    elsif api_corp_rec.maddr is not null and api_corp_rec.other_maddr is not null then
      mail_to := api_corp_rec.maddr || ',' || api_corp_rec.other_maddr;
    elsif api_corp_rec.maddr is null and api_corp_rec.other_maddr is not null then
      mail_to := mail_to || ',' || api_corp_rec.other_maddr;
      mail_cc := null;
    else
      mail_cc := null;
    end if;

    dbms_output.put_line(mail_to||'#'||mail_cc);
    --メール表題作成
    mail_subject := '';
    if (api_corp_rec.e_date <= sysdate()) then
        mail_subject := mail_subject || '[警告]';
    end if;
    mail_subject := mail_subject || '[期間満了間近]';
    mail_subject := mail_subject || '[' || api_corp_rec.cname || ']';
    mail_subject := mail_subject || '[' || api_corp_rec.usermei || ']';

   dbms_output.put_line(mail_subject);
    -- メール文章作成
    mail_msg := '';
    mail_msg := mail_msg || '-- API2.0サービス期間満了間近企業通知メール --' || chr(10);
    mail_msg := mail_msg || '※※　本メールを受信した担当者で、サービス継続が必要な場合は、必ずキー延長手続きを行ってください。' || chr(10);
    mail_msg := mail_msg || '※※　期限が切れると当サービスが使えなくなります。' || chr(10);
    mail_msg := mail_msg || '※※　詳細は営業部までお尋ね下さい。' || chr(10);
    mail_msg := mail_msg || chr(10);
    mail_msg := mail_msg || '---------------------------------' || chr(10);
    mail_msg := mail_msg || '企業ＩＤ:' || api_corp_rec.cid || chr(10);
    mail_msg := mail_msg || '企業名　:' || api_corp_rec.cname || chr(10);
    mail_msg := mail_msg || '利用期間:' || api_corp_rec.use_kikan || chr(10);
    mail_msg := mail_msg || '担当営業:' || api_corp_rec.usermei || chr(10);
    mail_msg := mail_msg || chr(10);
    mail_msg := mail_msg || '---------------------------------' || chr(10);
    mail_msg := mail_msg || 'API2.0基盤DBバッチ処理' || chr(10);

   dbms_output.put_line(mail_msg);

    -- メール送信
    mail_sender(
        i_from => mail_from,
        i_to => mail_to,
        i_cc => mail_cc,
        i_subject => mail_subject,
        i_message => mail_msg,
        rtncd => rtncd
    );

--/*
--    mail_msg := convert(mail_msg,'ISO2022-JP');
--
--    -- メール送信
--    UTL_MAIL.SEND (
--      sender      => mail_from,
--      recipients  => mail_to,
--      cc          => mail_cc,
--      bcc         => null,
--      subject     => mail_subject,
--      message     => mail_msg,
----      mime_type   => 'text/plain; charset=shift-jis',
--      mime_type    => 'text/plain; charset=iso-2022-jp',
--      priority    => null
--    );
--*/
  end loop;

  --リターンコードセット
  rtncd := 0;

exception
  when others then
    rtncd := 9;
end;