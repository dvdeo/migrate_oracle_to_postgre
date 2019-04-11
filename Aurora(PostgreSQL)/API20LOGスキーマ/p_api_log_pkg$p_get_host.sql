CREATE OR REPLACE FUNCTION api20log.p_api_log_pkg$p_get_host(IN i_cid TEXT, IN i_month TEXT, IN i_ym TEXT, IN i_order DOUBLE PRECISION, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_rtncd DOUBLE PRECISION, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* */
/* １ヶ月検索用カーソル */
/* */
DECLARE
    log_cur_1 CURSOR (i_cid TEXT, i_ym TEXT, i_order TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        *
        FROM (SELECT
            o.*, COUNT(*) OVER () AS all_cnt, ROW_NUMBER() OVER (ORDER BY rnk, host) AS rnum
            FROM (SELECT
                l.*
                FROM (SELECT
                    l.host, SUM(l.cnt) AS cnt, RANK() OVER (ORDER BY SUM(l.cnt) DESC) AS rnk
                    FROM api20log.host_top100_log AS l
                    WHERE
                    CASE i_cid
                        WHEN NULL THEN 1
                        ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                    END != 0 AND l.ym = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                    /* and l.ym between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                    GROUP BY l.host) AS l
                WHERE rnk <= i_order::NUMERIC) AS o) AS var_sbq
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* ３ヶ月検索用カーソル */
    /* */;
    log_cur_3 CURSOR (i_cid TEXT, i_ym TEXT, i_order TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        *
        FROM (SELECT
            o.*, COUNT(*) OVER () AS all_cnt, ROW_NUMBER() OVER (ORDER BY rnk, host) AS rnum
            FROM (SELECT
                l.*
                FROM (SELECT
                    l.host, SUM(l.cnt) AS cnt, RANK() OVER (ORDER BY SUM(l.cnt) DESC) AS rnk
                    FROM api20log.host_top100_log AS l
                    WHERE
                    CASE i_cid
                        WHEN NULL THEN 1
                        ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                    END != 0
                    /* and l.ym = nvl(i_ym, to_char(sysdate,'yyyymm')) */
                    AND l.ym BETWEEN COALESCE(aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_ym, 'yyyymm'), - 2), 'yyyymm'), aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.SYSDATE(), - 2), 'yyyymm')) AND COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                    GROUP BY l.host) AS l
                WHERE rnk <= i_order::NUMERIC) AS o) AS var_sbq_2
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* ワーク変数 */;
    w_cnt INTEGER;
    w_msg CHARACTER VARYING(500);
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20log.p_api_log_pkg$p_get_host');
    o_rtncd := 0;
    o_cnt := 0;

    IF i_month = '1'
    /* データ取得 */
    THEN
        w_cnt := 0;

        FOR log_rec IN log_cur_1 (i_cid, api20log.chg_ym(i_ym), i_order, i_pos, i_cnt) LOOP
            w_cnt := w_cnt + 1;
            PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_host', CONCAT_WS('', 'rank', ':"', log_rec.rnk, '",', 'host', ':"', log_rec.host, '",', 'cnt', ':"', log_rec.cnt, '"'));
            o_cnt := log_rec.all_cnt;
        END LOOP;
    /* データ取得 */
    ELSE
        w_cnt := 0;

        FOR log_rec IN log_cur_3 (i_cid, api20log.chg_ym(i_ym), i_order, i_pos, i_cnt) LOOP
            w_cnt := w_cnt + 1;
            PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_host', CONCAT_WS('', 'rank', ':"', log_rec.rnk, '",', 'host', ':"', log_rec.host, '",', 'cnt', ':"', log_rec.cnt, '"'));
            o_cnt := log_rec.all_cnt;
        END LOOP;
    END IF;
    o_rtncd := 0
    /* 正常終了 */;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20log.p_api_log_pkg$p_get_host', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20log.p_api_log_pkg$p_get_host');
    EXCEPTION
        WHEN others THEN
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg := substrb(sqlerrm, 1, 500)
            */
            /* insert into error_log values(sysdate, 'P_GET_HOST', i_cid, w_msg); */
            /* commit; */
            o_rtncd := 7000;
END;
$BODY$
LANGUAGE  plpgsql;