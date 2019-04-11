CREATE OR REPLACE FUNCTION api20ninsyo.p_api20_ninsyo(IN i_cid TEXT, IN i_referer TEXT, OUT o_rtncd TEXT)
AS
$BODY$
/* API認証テーブルカーソル */
DECLARE
    /*
    [5095 - Severity CRITICAL - PostgreSQL doesn't support using a materialized VIEW. Revise your code to replace materialized VIEW with another solution., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    CURSOR auth_cur(i_cid varchar2, i_referer varchar2) IS
            select cid,
                   referer,
                   -- サービス期間チェック（1:期間内、0:期間外）
                   case
                     when trunc(sysdate) between trunc(s_date) and trunc(e_date) then '1'
                     else '0'
                   end srv_date_flg
            from  auth_mview
            where cid = i_cid
            and   instr(i_referer ,replace(referer,'*','') ) = 1
    */
    /* リファラーに*が含まれていても前方一致 */
    /* 例)登録済みリファラー「http://xx-xxx/*」の場合、「http://xx-xxx/yyy」でも認証可*/ */
    auth_rec record;
    rtncd CHARACTER(4);
    auth_cur$FOUND BOOLEAN DEFAULT false;
/* リターンコード */
BEGIN
    rtncd := NULL
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    OPEN auth_cur(i_cid, i_referer)
    */
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    FETCH auth_cur INTO auth_rec
    */;
    auth_cur$FOUND := FOUND;

    IF (NOT auth_cur$FOUND)
    /* 認証エラー(企業ID or リファラー不一致) */
    THEN
        rtncd := '0001';
    ELSE
        IF auth_rec.srv_date_flg = '0'
        /* 利用期間外エラー */
        THEN
            rtncd := '0002';
        ELSE
            rtncd := '0000';
        END IF;
    END IF
    /*
    [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    CLOSE auth_cur
    */
    /* '7001'：その他エラー テスト用 */
    /* update auth_mview set cid = 'BBB' where cid = 'TestCGI1'; */;
    o_rtncd := rtncd;
    EXCEPTION
        WHEN others THEN
            o_rtncd := '7001';
END;
$BODY$
LANGUAGE  plpgsql;