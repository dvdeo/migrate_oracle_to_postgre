CREATE OR REPLACE FUNCTION api20ninsyo.p_api20_end_mail(IN i_yymmdd TIMESTAMP WITHOUT TIME ZONE, OUT rtncd DOUBLE PRECISION)
AS
$BODY$
/* API企業マスタカーソル */
DECLARE
    /*
    [5605 - Severity CRITICAL - PostgreSQL doesn't support use of dblinks. Use another method for this functionality., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
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
        and   c.e_date <= i_yymmdd
    */
    /* ワーク変数 */
    mail_msg CHARACTER VARYING(2000);
    mail_subject CHARACTER VARYING(2000);
    mail_to CHARACTER VARYING(1000);
    mail_cc CHARACTER VARYING(1000);
    mail_from CHARACTER VARYING(100);
    wk_mail_to CHARACTER VARYING(1000);
    wk_mail_cc CHARACTER VARYING(1000);
    wk_mail_from CHARACTER VARYING(100);
/* メールアドレス取得 */
BEGIN
    SELECT
        to_maddr, to_maddr, from_maddr
        INTO STRICT wk_mail_to, wk_mail_cc, wk_mail_from
        FROM api20ninsyo.mail_addr_tbl
        WHERE kubun = 'BO'
    /* 企業カーソルオープン */;

    FOR api_corp_rec IN api_corp_cur (i_yymmdd) LOOP
        mail_to := wk_mail_to;
        mail_cc := wk_mail_cc;
        mail_from := wk_mail_from
        /* ZDC_UIDにメールアドレスが設定されていればソレを優先 */
        /* なければ、MAIL_ADDR_TBLの区分'BO'のメールアドレスを使用 */
        /* さらに、API_CORP_MAILに関係者メールアドレスレコードが存在すれば、ソレも結合 */
        /* ZDC_UIDにメールアドレスが設定されている場合に限り、CCとしてMAIL_ADDR_TBLの区分'BO'のメールアドレスを設定する */
        /* 何も設定がない場合は、MAIL_ADDR_TBLの区分'BO'宛にメールする */;

        IF api_corp_rec.maddr IS NOT NULL AND api_corp_rec.other_maddr IS NULL THEN
            /*
            [9993 - Severity CRITICAL - Unable to transform statement due to references to unresolved object. Verify if unresolved object is present in the database. If it isn't, check the object name or add the object. If the object is present, please submit report to developers.]
            mail_to := api_corp_rec.maddr
            */
            BEGIN
            END;
        ELSIF api_corp_rec.maddr IS NOT NULL AND api_corp_rec.other_maddr IS NOT NULL THEN
            /*
            [9993 - Severity CRITICAL - Unable to transform statement due to references to unresolved object. Verify if unresolved object is present in the database. If it isn't, check the object name or add the object. If the object is present, please submit report to developers.]
            mail_to := api_corp_rec.maddr || ',' || api_corp_rec.other_maddr
            */
            BEGIN
            END;
        ELSIF api_corp_rec.maddr IS NULL AND api_corp_rec.other_maddr IS NOT NULL THEN
            mail_to := CONCAT_WS('', mail_to, ',', api_corp_rec.other_maddr);
            mail_cc := NULL;
        ELSE
            mail_cc := NULL;
        END IF;
        RAISE DEBUG USING MESSAGE = CONCAT_WS('', mail_to, '#', mail_cc)
        /* メール表題作成 */;
        mail_subject := '';

        IF (api_corp_rec.e_date <= aws_oracle_ext.SYSDATE()) THEN
            mail_subject := CONCAT_WS('', mail_subject, '[警告]');
        END IF;
        mail_subject := CONCAT_WS('', mail_subject, '[期間満了間近]');
        mail_subject := CONCAT_WS('', mail_subject, '[', api_corp_rec.cname, ']')
        /*
        [9993 - Severity CRITICAL - Unable to transform statement due to references to unresolved object. Verify if unresolved object is present in the database. If it isn't, check the object name or add the object. If the object is present, please submit report to developers.]
        mail_subject := mail_subject || '[' || api_corp_rec.usermei || ']'
        */;
        RAISE DEBUG USING MESSAGE = mail_subject::TEXT
        /* メール文章作成 */;
        mail_msg := '';
        mail_msg := CONCAT_WS('', mail_msg, '-- API2.0サービス期間満了間近企業通知メール --', CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '※※　本メールを受信した担当者で、サービス継続が必要な場合は、必ずキー延長手続きを行ってください。', CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '※※　期限が切れると当サービスが使えなくなります。', CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '※※　詳細は営業部までお尋ね下さい。', CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '---------------------------------', CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '企業ＩＤ:', api_corp_rec.cid, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '企業名　:', api_corp_rec.cname, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '利用期間:', api_corp_rec.use_kikan, CHR(10))
        /*
        [9993 - Severity CRITICAL - Unable to transform statement due to references to unresolved object. Verify if unresolved object is present in the database. If it isn't, check the object name or add the object. If the object is present, please submit report to developers.]
        mail_msg := mail_msg || '担当営業:' || api_corp_rec.usermei || chr(10)
        */;
        mail_msg := CONCAT_WS('', mail_msg, CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, '---------------------------------', CHR(10));
        mail_msg := CONCAT_WS('', mail_msg, 'API2.0基盤DBバッチ処理', CHR(10));
        RAISE DEBUG USING MESSAGE = mail_msg::TEXT
        /* メール送信 */;
        SELECT
            *
            FROM api20ninsyo.mail_sender(i_from := mail_from, i_to := mail_to, i_cc := mail_cc, i_subject := mail_subject, i_message := mail_msg)
            INTO rtncd;
        /* /**/ */
        /* mail_msg := convert(mail_msg,'ISO2022-JP'); */
        /* */
        /* -- メール送信 */
        /* UTL_MAIL.SEND ( */
        /* sender      => mail_from, */
        /* recipients  => mail_to, */
        /* cc          => mail_cc, */
        /* bcc         => null, */
        /* subject     => mail_subject, */
        /* message     => mail_msg, */
        /* --      mime_type   => 'text/plain; charset=shift-jis', */
        /* mime_type    => 'text/plain; charset=iso-2022-jp', */
        /* priority    => null */
        /* ); */
        /* * / */
    END LOOP
    /* リターンコードセット */;
    rtncd := 0;
    EXCEPTION
        WHEN others THEN
            rtncd := 9;
END;
$BODY$
LANGUAGE  plpgsql;