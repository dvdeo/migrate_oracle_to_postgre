CREATE OR REPLACE FUNCTION api20ninsyo.fcorp_mst_update_mail(IN i_cid TEXT, IN i_kbn TEXT, IN i_uid TEXT, OUT rtncd DOUBLE PRECISION)
AS
$BODY$
/* ZDC社員マスタ検索カーソル */
DECLARE
    /*
    [5605 - Severity CRITICAL - PostgreSQL doesn't support use of dblinks. Use another method for this functionality., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    cursor uid_cur(i_uid varchar2) is
        select usermei
        from zdc_uid
      where userid = i_uid
    */
    /* ZDC社員レコード定義 */
    uid_rec record
    /* API企業マスタ検索カーソル */
    /*
    [5605 - Severity CRITICAL - PostgreSQL doesn't support use of dblinks. Use another method for this functionality., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
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
      and   c.cid      = i_corp_id
    */
    /* API企業レコード定義 */;
    corp_rec record
    /* ワーク変数 */;
    w_kbn CHARACTER VARYING(10);
    w_usermei CHARACTER VARYING(20);
    mail_msg CHARACTER VARYING(4000);
    mail_subject CHARACTER VARYING(2000);
    mail_to CHARACTER VARYING(1000);
    mail_cc CHARACTER VARYING(1000);
    mail_from CHARACTER VARYING(100);
    uid_cur$FOUND BOOLEAN DEFAULT false;
    corp_cur$FOUND BOOLEAN DEFAULT false;
/* 処理区分設定 */
BEGIN
    CASE i_kbn
        WHEN 'I' THEN
            w_kbn := '追加';
        WHEN 'U' THEN
            w_kbn := '変更';
        WHEN 'D' THEN
            w_kbn := '削除';
        ELSE
            w_kbn := '未定';
    END CASE
    /* 処理者名設定 */
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    open uid_cur(i_uid)
    */
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    fetch uid_cur into uid_rec
    */;
    uid_cur$FOUND := FOUND;

    IF uid_cur$FOUND THEN
        w_usermei := uid_rec.usermei;
    ELSE
        w_usermei := CONCAT_WS('', '社員コード=', i_uid);
    END IF
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    close uid_cur
    */
    /* 企業カーソルオープン */
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    open corp_cur(i_cid)
    */
    /* 企業データ読み込み */
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    fetch corp_cur into corp_rec
    */;
    corp_cur$FOUND := FOUND
    /* メールアドレス取得 */;
    SELECT
        to_maddr, to_maddr, from_maddr
        INTO STRICT mail_to, mail_cc, mail_from
        FROM api20ninsyo.mail_addr_tbl
        WHERE kubun = 'BO';

    IF corp_cur$FOUND
    /* 企業データ有り？ */
    /* ZDC_UIDにメールアドレスが設定されていればソレを優先 */
    /* なければ、MAIL_ADDR_TBLの区分'BO'のメールアドレスを使用 */
    /* さらに、API_CORP_MAILに関係者メールアドレスレコードが存在すれば、ソレも結合 */
    /* ZDC_UIDにメールアドレスが設定されている場合に限り、CCとしてMAIL_ADDR_TBLの区分'BO'のメールアドレスを設定する */
    /* 何も設定がない場合は、MAIL_ADDR_TBLの区分'BO'宛にメールする */
    /* 2015.01.22 、MAIL_ADDR_TBLの区分'BO'宛には送信しない */
    THEN
        IF corp_rec.maddr IS NOT NULL AND corp_rec.other_maddr IS NULL THEN
            mail_to := corp_rec.maddr;
            mail_cc := NULL;
        ELSIF corp_rec.maddr IS NOT NULL AND corp_rec.other_maddr IS NOT NULL THEN
            mail_to := CONCAT_WS('', corp_rec.maddr, ',', corp_rec.other_maddr);
            mail_cc := NULL;
        ELSIF corp_rec.maddr IS NULL AND corp_rec.other_maddr IS NOT NULL THEN
            mail_to := corp_rec.other_maddr;
            mail_cc := NULL;
        ELSE
            mail_cc := NULL;
        END IF
        /* メール表題作成 */;
        mail_subject := '';
        mail_subject := CONCAT_WS('', mail_subject, '[', w_kbn, ']');
        mail_subject := CONCAT_WS('', mail_subject, '[', corp_rec.cname, ']');
        mail_subject := CONCAT_WS('', mail_subject, '[', corp_rec.usermei, ']')
        /* メール文章作成 */;
        mail_msg := '';
        mail_msg := CONCAT_WS('', mail_msg, '-- API2.0顧客マスタ(無償版)更新通知メール --', CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '更新日時:', corp_rec.update_date, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '更新者　:', w_usermei, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '企業ＩＤ:', corp_rec.cid, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '企業名　:', corp_rec.cname, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '利用期間:', corp_rec.use_kikan, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '担当営業:', corp_rec.usermei, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '---------------------------------', CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, 'API2.0基盤バックオフィス', CHR(10));
        SELECT
            *
            FROM api20ninsyo.mail_sender(i_from := mail_from, i_to := mail_to, i_cc := mail_cc, i_subject := mail_subject, i_message := mail_msg)
            INTO rtncd
        /* リターンコードセット */;
        rtncd := 0;
    /* 企業データ無し */
    /* リターンコードセット */
    ELSE
        rtncd := 1;
    END IF
    /* 企業カーソルクローズ */
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    close corp_cur
    */;
    EXCEPTION
        WHEN others THEN
            rtncd := 9;
END;
$BODY$
LANGUAGE  plpgsql;