CREATE OR REPLACE FUNCTION api20log.p_api_log_pkg$p_get_fapi(IN i_cid TEXT, IN i_ym TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_rtncd DOUBLE PRECISION, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* */
/* 全体、１ヶ月検索用カーソル */
/* */
DECLARE
    log_cur_t_1 CURSOR (i_cid TEXT, i_ym TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        p.*
        FROM (SELECT
            o.*, COUNT(*) OVER () AS all_cnt, ROW_NUMBER() OVER (ORDER BY dispnum) AS rnum
            FROM (SELECT
                cid, api, dispnum, ym, total, min_ym, max_ym, aws_oracle_ext.TO_NUMBER(aws_oracle_ext.TO_CHAR(aws_oracle_ext.LAST_DAY(aws_oracle_ext.TO_DATE(ym, 'YYYYMM')), 'dd')) AS sum_cnt
                FROM (SELECT
                    a.cid, COALESCE(a.ym, i_ym) AS ym, b.api, b.dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.min_ym, i_ym) AS min_ym, COALESCE(a.max_ym, i_ym) AS max_ym
                    FROM (SELECT
                        l.cid, l.ym, '全体' AS api, 1 AS dispnum, SUM(COALESCE(l.total, 0)) AS total, MIN(l.ym) AS min_ym, MAX(l.ym) AS max_ym
                        FROM api20log.api20_date_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND l.cid IN (SELECT
                            cid
                            FROM api20ninsyo.fapi20_corp_mst) AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND ym = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        GROUP BY l.cid, l.ym) AS a, (SELECT
                        '全体' AS api, 1 AS dispnum) AS b
                    WHERE a.api = b.api) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* ワーク変数 */;
    w_cnt INTEGER;
    w_msg CHARACTER VARYING(500);
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20log.p_api_log_pkg$p_get_fapi');
    o_rtncd := 0;
    o_cnt := 0
    /* データ取得 */;
    w_cnt := 0;

    FOR log_rec IN log_cur_t_1 (i_cid, api20log.chg_ym(i_ym), i_pos, i_cnt) LOOP
        w_cnt := w_cnt + 1;
        PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_fapi', CONCAT_WS('', 'cid', ':"', log_rec.cid, '",', 'total', ':"', log_rec.total, '"'));
        o_cnt := log_rec.all_cnt;
    END LOOP;
    o_rtncd := 0
    /* 正常終了 */;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20log.p_api_log_pkg$p_get_fapi', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20log.p_api_log_pkg$p_get_fapi');
    EXCEPTION
        WHEN others THEN
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg := substrb(sqlerrm, 1, 500)
            */
            /* insert into error_log values(sysdate, 'P_GET_FAPI', i_cid, w_msg); */
            /* commit; */
            o_rtncd := 7000;
END;
$BODY$
LANGUAGE  plpgsql;