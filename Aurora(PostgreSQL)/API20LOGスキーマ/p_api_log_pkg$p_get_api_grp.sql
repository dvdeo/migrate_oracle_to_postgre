CREATE OR REPLACE FUNCTION api20log.p_api_log_pkg$p_get_api_grp(IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_rtncd DOUBLE PRECISION, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
DECLARE
    api_grp_cur CURSOR (i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        *
        FROM (SELECT
            p.*, ROW_NUMBER() OVER (ORDER BY grp_dispnum) AS rnum
            FROM (SELECT
                o.*, COUNT(*) OVER () AS all_cnt
                FROM (SELECT DISTINCT
                    m.func_grp_name, m.grp_dispnum
                    FROM api20log.api20_mst AS m) AS o) AS p) AS var_sbq
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* ワーク変数 */;
    w_cnt INTEGER;
    w_msg CHARACTER VARYING(500);
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20log.p_api_log_pkg$p_get_api_grp');
    o_rtncd := 0;
    o_cnt := 0
    /* データ取得 */;
    w_cnt := 0;

    FOR api_grp_rec IN api_grp_cur (i_pos, i_cnt) LOOP
        w_cnt := w_cnt + 1;
        PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_api_grp', CONCAT_WS('', 'grp_name', ':"', api_grp_rec.func_grp_name, '"'));
        o_cnt := api_grp_rec.all_cnt;
    END LOOP;
    o_rtncd := 0
    /* 正常終了 */;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20log.p_api_log_pkg$p_get_api_grp', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20log.p_api_log_pkg$p_get_api_grp');
    EXCEPTION
        WHEN others THEN
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg := substrb(sqlerrm, 1, 500)
            */
            /* insert into error_log values(sysdate, 'P_GET_API_GRP', null, w_msg); */
            /* commit; */
            o_rtncd := 7000;
END;
$BODY$
LANGUAGE  plpgsql;