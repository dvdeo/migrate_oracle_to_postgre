CREATE OR REPLACE FUNCTION api20log.p_api_log_pkg$p_get_api_corp(IN i_cid TEXT, IN i_cname TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_rtncd DOUBLE PRECISION, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
DECLARE
    corp_cur CURSOR (i_cid TEXT, i_cname TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        *
        FROM (SELECT
            p.*, ROW_NUMBER() OVER (ORDER BY cname) AS rnum
            /* 2011.02.14  玉川  ソート順をCIDからCNAMEに変更 */
            FROM (SELECT
                o.*, COUNT(*) OVER () AS all_cnt
                FROM (SELECT
                    c.cid, c.cname
                    FROM api20ninsyo.api20_corp_mst AS c
                    WHERE
                    CASE i_cid
                        WHEN NULL THEN 1
                        ELSE aws_oracle_ext.INSTR(c.cid, i_cid)
                    END != 0 AND
                    CASE i_cname
                        WHEN NULL THEN 1
                        ELSE aws_oracle_ext.INSTR(c.cname, i_cname)
                    END != 0) AS o) AS p) AS var_sbq
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* ワーク変数 */;
    w_cnt INTEGER;
    w_msg CHARACTER VARYING(500);
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20log.p_api_log_pkg$p_get_api_corp');
    o_rtncd := 0;
    o_cnt := 0
    /* データ取得 */;
    w_cnt := 0;

    FOR corp_rec IN corp_cur (i_cid, i_cname, i_pos, i_cnt) LOOP
        w_cnt := w_cnt + 1;
        PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_api_corp', CONCAT_WS('', 'cid', ':"', corp_rec.cid, '",', 'cname', ':"', corp_rec.cname, '"'));
        o_cnt := corp_rec.all_cnt;
    END LOOP;
    o_rtncd := 0
    /* 正常終了 */;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20log.p_api_log_pkg$p_get_api_corp', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20log.p_api_log_pkg$p_get_api_corp');
    EXCEPTION
        WHEN others THEN
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg := substrb(sqlerrm, 1, 500)
            */
            /* insert into error_log values(sysdate, 'P_GET_API_CORP', i_cid, w_msg); */
            /* commit; */
            o_rtncd := 7000;
END;
$BODY$
LANGUAGE  plpgsql;