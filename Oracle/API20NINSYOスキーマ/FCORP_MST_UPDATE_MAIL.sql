CREATE OR REPLACE PROCEDURE "API20NINSYO".fcorp_mst_update_mail(
  i_cid        in    varchar2,    -- 企業ID
  i_kbn        in    varchar2,    -- 処理区分
  i_uid        in    varchar2,    -- 処理者ID
  rtncd        out   number       -- リターンコード
) is
  -- ZDC社員マスタ検索カーソル
  cursor uid_cur(i_uid varchar2) is
    select usermei
    from zdc_uid
  where userid = i_uid;

  -- ZDC社員レコード定義
  uid_rec    uid_cur%ROWTYPE;

  -- API企業マスタ検索カーソル
  cursor corp_cur(i_corp_id varchar2) is
  select
    to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') update_date,
    c.cid,
    c.cname,
    to_char(c.s_date,'yyyy/mm/dd') || ' - ' || to_char(c.e_date,'yyyy/mm/dd') use_kikan,
    c.end_flg,
    u.usermei,
    u.maddr,
    replace(c.other_maddr,'\','') other_maddr
  from fapi20_corp_mst c, zdc_uid u
  where c.sales_id = u.userid
  and   c.cid      = i_corp_id;

  -- API企業レコード定義
  corp_rec    corp_cur%ROWTYPE;

  -- ワーク変数
  w_kbn         varchar2(10);
  w_usermei     varchar2(20);

  mail_msg      varchar2(4000);
  mail_subject  varchar2(2000);
  mail_to       varchar2(1000);
  mail_cc       varchar2(1000);
  mail_from     varchar2(100);

begin

  -- 処理区分設定
  case i_kbn
    when 'I' then w_kbn := '追加';
    when 'U' then w_kbn := '変更';
    when 'D' then w_kbn := '削除';
    else          w_kbn := '未定';
  end case;

  -- 処理者名設定
  open uid_cur(i_uid);
  fetch uid_cur into uid_rec;

  if uid_cur%FOUND then
    w_usermei := uid_rec.usermei;
  else
    w_usermei := '社員コード=' || i_uid;
  end if;
  close uid_cur;

  -- 企業カーソルオープン
  open corp_cur(i_cid);

  -- 企業データ読み込み
  fetch corp_cur into corp_rec;

  -- メールアドレス取得
  select to_maddr,to_maddr, from_maddr
  into mail_to, mail_cc,mail_from
  from mail_addr_tbl
  where kubun = 'BO';


     if corp_cur%FOUND then     -- 企業データ有り？

         --ZDC_UIDにメールアドレスが設定されていればソレを優先
         --なければ、MAIL_ADDR_TBLの区分'BO'のメールアドレスを使用
         --さらに、API_CORP_MAILに関係者メールアドレスレコードが存在すれば、ソレも結合
         --ZDC_UIDにメールアドレスが設定されている場合に限り、CCとしてMAIL_ADDR_TBLの区分'BO'のメールアドレスを設定する
         --何も設定がない場合は、MAIL_ADDR_TBLの区分'BO'宛にメールする
         --2015.01.22 、MAIL_ADDR_TBLの区分'BO'宛には送信しない
         if corp_rec.maddr is not null and corp_rec.other_maddr is null then
           mail_to := corp_rec.maddr;
           mail_cc := null;
         elsif corp_rec.maddr is not null and corp_rec.other_maddr is not null then
           mail_to := corp_rec.maddr || ',' || corp_rec.other_maddr;
           mail_cc := null;
         elsif corp_rec.maddr is null and corp_rec.other_maddr is not null then
           mail_to := corp_rec.other_maddr;
           mail_cc := null;
         else
           mail_cc := null;
         end if;

         --メール表題作成
         mail_subject := '';
         mail_subject := mail_subject || '[' || w_kbn || ']';
         mail_subject := mail_subject || '[' || corp_rec.cname || ']';
         mail_subject := mail_subject || '[' || corp_rec.usermei || ']';

         -- メール文章作成
         mail_msg := '';
         mail_msg := mail_msg || '-- API2.0顧客マスタ(無償版)更新通知メール --' || chr(10);
         mail_msg := mail_msg || chr(10);
         mail_msg := mail_msg || '更新日時:' || corp_rec.update_date || chr(10);
         mail_msg := mail_msg || '更新者　:' || w_usermei || chr(10);
         mail_msg := mail_msg || '企業ＩＤ:' || corp_rec.cid || chr(10);
         mail_msg := mail_msg || '企業名　:' || corp_rec.cname || chr(10);
         mail_msg := mail_msg || '利用期間:' || corp_rec.use_kikan || chr(10);
         mail_msg := mail_msg || '担当営業:' || corp_rec.usermei || chr(10);

         mail_msg := mail_msg || chr(10);
         mail_msg := mail_msg || '---------------------------------' || chr(10);
         mail_msg := mail_msg || 'API2.0基盤バックオフィス' || chr(10);

         mail_sender(
             i_from    => mail_from,
             i_to      => mail_to,
             i_cc      => mail_cc,
             i_subject => mail_subject,
             i_message => mail_msg,
             rtncd     => rtncd
         );

    --リターンコードセット
    rtncd := 0;

     else    -- 企業データ無し

     -- リターンコードセット
     rtncd := 1;

  end if;

  -- 企業カーソルクローズ
  close corp_cur;

exception
  when others then
    rtncd := 9;
end;