CREATE OR REPLACE FUNCTION api20log.p_api_log_pkg$p_get_time_func(IN i_cid TEXT, IN i_kbn TEXT, IN i_ymd TEXT, IN i_func TEXT, IN i_ssl TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_rtncd DOUBLE PRECISION, OUT o_cnt DOUBLE PRECISION, OUT o_gokei DOUBLE PRECISION, OUT o_avg DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* */
/* 機能名指定カーソル */
/* */
DECLARE
    log_cur_f CURSOR (i_cid TEXT, i_func TEXT, i_ymd TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        p.*, ROUND(total /
        CASE gokei
            WHEN 0 THEN 1
            ELSE gokei
        END::NUMERIC * 100, 1) AS rate, ROUND(gokei /
        CASE sum_cnt
            WHEN 0 THEN 1
            ELSE sum_cnt
        END::NUMERIC, 0) AS avg_cnt
        FROM (SELECT
            o.*, SUM(total) OVER () AS gokei, COUNT(*) OVER () AS all_cnt, ROW_NUMBER() OVER (ORDER BY api) AS rnum
            FROM (SELECT
                l.*, 24 AS sum_cnt
                FROM (SELECT
                    b.ymd, b.func_name, b.func_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd') AS ymd, m.func_name AS api, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_func
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_func, m.func_name)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd') = COALESCE(i_ymd, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymmdd'))
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd'), m.func_name) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        i_ymd AS ymd, m.func_name AS api, m.func_dispnum AS dispnum
                        FROM api20log.api20_mst AS m
                        WHERE m.func_name = i_func) AS b
                        ON (a.func_name = b.func_name)
                    WHERE a.ymd = b.ymd) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 機能グループ名指定カーソル */
    /* */;
    log_cur_g CURSOR (i_cid TEXT, i_func TEXT, i_ymd TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        p.*, ROUND(total /
        CASE gokei
            WHEN 0 THEN 1
            ELSE gokei
        END::NUMERIC * 100, 1) AS rate, ROUND(gokei /
        CASE sum_cnt
            WHEN 0 THEN 1
            ELSE sum_cnt
        END::NUMERIC, 0) AS avg_cnt
        FROM (SELECT
            o.*, SUM(total) OVER () AS gokei, COUNT(*) OVER () AS all_cnt, ROW_NUMBER() OVER (ORDER BY api) AS rnum
            FROM (SELECT
                l.*, 24 AS sum_cnt
                FROM (SELECT
                    b.ymd, b.func_name, b.func_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd') AS ymd, m.func_name AS api, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_func
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_func, m.func_grp_name)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd') = COALESCE(i_ymd, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymmdd'))
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd'), m.func_name) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        i_ymd AS ymd, m.func_name AS api, m.func_dispnum AS dispnum
                        FROM api20log.api20_mst AS m
                        WHERE m.func_grp_name = i_func) AS b
                        ON (a.func_name = b.func_name)
                    WHERE a.ymd = b.ymd) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* サマリー指定カーソル */
    /* */;
    log_cur_s CURSOR (i_cid TEXT, i_ymd TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        p.*, ROUND(total /
        CASE gokei
            WHEN 0 THEN 1
            ELSE gokei
        END::NUMERIC * 100, 1) AS rate, ROUND(gokei /
        CASE sum_cnt
            WHEN 0 THEN 1
            ELSE sum_cnt
        END::NUMERIC, 0) AS avg_cnt
        FROM (SELECT
            o.*, SUM(total) OVER () AS gokei, COUNT(*) OVER () AS all_cnt, ROW_NUMBER() OVER (ORDER BY dispnum) AS rnum
            FROM (SELECT
                l.*, 24 AS sum_cnt
                FROM (SELECT
                    b.ymd, b.func_grp_name, b.grp_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd') AS ymd, m.func_grp_name AS api, m.grp_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd') = COALESCE(i_ymd, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymmdd'))
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd'), m.func_grp_name, m.grp_dispnum) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        i_ymd AS ymd, m.func_grp_name AS api, m.grp_dispnum AS dispnum
                        FROM api20log.api20_mst AS m) AS b
                        ON (a.func_grp_name = b.func_grp_name)
                    WHERE a.ymd = b.ymd) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 全体指定カーソル */
    /* */;
    log_cur_t CURSOR (i_cid TEXT, i_ymd TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        p.*, ROUND(total /
        CASE gokei
            WHEN 0 THEN 1
            ELSE gokei
        END::NUMERIC * 100, 1) AS rate, ROUND(gokei /
        CASE sum_cnt
            WHEN 0 THEN 1
            ELSE sum_cnt
        END::NUMERIC, 0) AS avg_cnt
        FROM (SELECT
            o.*, SUM(total) OVER () AS gokei, COUNT(*) OVER () AS all_cnt, ROW_NUMBER() OVER (ORDER BY api) AS rnum
            FROM (SELECT
                l.*, 24 AS sum_cnt
                FROM (SELECT
                    b.ymd, b.api, b.dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd') AS ymd, '全体' AS api, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd') = COALESCE(i_ymd, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymmdd'))
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymmdd')) AS a, (SELECT DISTINCT
                        i_ymd AS ymd, '全体' AS api, 1 AS dispnum) AS b
                    WHERE a.api = b.api AND a.ymd = b.ymd) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* ワーク変数 */;
    w_cnt INTEGER;
    w_msg CHARACTER VARYING(500);
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20log.p_api_log_pkg$p_get_time_func');
    o_rtncd := 0;
    o_cnt := 0;
    CASE i_kbn
        WHEN 'F'
        /* データ取得 */
        THEN
            w_cnt := 0;

            FOR log_rec IN log_cur_f (i_cid, i_func, i_ymd, i_ssl, i_pos, i_cnt) LOOP
                w_cnt := w_cnt + 1;
                PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time_func', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                o_cnt := log_rec.all_cnt;
                o_gokei := log_rec.gokei;
                o_avg := log_rec.avg_cnt;
            END LOOP;
        WHEN 'G'
        /* データ取得 */
        THEN
            w_cnt := 0;

            FOR log_rec IN log_cur_g (i_cid, i_func, i_ymd, i_ssl, i_pos, i_cnt) LOOP
                w_cnt := w_cnt + 1;
                PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time_func', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                o_cnt := log_rec.all_cnt;
                o_gokei := log_rec.gokei;
                o_avg := log_rec.avg_cnt;
            END LOOP;
        WHEN 'S'
        /* データ取得 */
        THEN
            w_cnt := 0;

            FOR log_rec IN log_cur_s (i_cid, i_ymd, i_ssl, i_pos, i_cnt) LOOP
                w_cnt := w_cnt + 1;
                PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time_func', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                o_cnt := log_rec.all_cnt;
                o_gokei := log_rec.gokei;
                o_avg := log_rec.avg_cnt;
            END LOOP;
        WHEN 'T'
        /* データ取得 */
        THEN
            w_cnt := 0;

            FOR log_rec IN log_cur_t (i_cid, i_ymd, i_ssl, i_pos, i_cnt) LOOP
                w_cnt := w_cnt + 1;
                PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time_func', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                o_cnt := log_rec.all_cnt;
                o_gokei := log_rec.gokei;
                o_avg := log_rec.avg_cnt;
            END LOOP;
        ELSE
            NULL;
    END CASE;
    o_rtncd := 0
    /* 正常終了 */;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20log.p_api_log_pkg$p_get_time_func', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20log.p_api_log_pkg$p_get_time_func');
    EXCEPTION
        WHEN others THEN
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg := substrb(sqlerrm, 1, 500)
            */
            /* insert into error_log values(sysdate, 'P_GET_TIME_FUNC', i_cid, w_msg); */
            /* commit; */
            o_rtncd := 7000;
END;
$BODY$
LANGUAGE  plpgsql;