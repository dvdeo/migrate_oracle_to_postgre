CREATE OR REPLACE FUNCTION api20log.p_api_log_pkg$p_get_time(IN i_cid TEXT, IN i_kbn TEXT, IN i_month TEXT, IN i_ym TEXT, IN i_grp TEXT, IN i_ssl TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_rtncd DOUBLE PRECISION, OUT o_cnt DOUBLE PRECISION, OUT o_min_ym TEXT, OUT o_max_ym TEXT, OUT o_gokei DOUBLE PRECISION, OUT o_avg DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* */
/* 全体、１ヶ月検索用カーソル */
/* */
DECLARE
    log_cur_t_1 CURSOR (i_cid TEXT, i_ym TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
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
                    COALESCE(a.ym, i_ym) AS ym, b.api, b.dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.min_ym, i_ym) AS min_ym, COALESCE(a.max_ym, i_ym) AS max_ym, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') AS ym, '全体' AS api, 1 AS dispnum, SUM(COALESCE(l.total, 0)) AS total, MIN(aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm')) AS min_ym, MAX(aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm')) AS max_ym, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        /* and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm')) AS a, (SELECT
                        '全体' AS api, 1 AS dispnum) AS b
                    WHERE a.api = b.api) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 全体、３ヶ月検索用カーソル */
    /* */;
    log_cur_t_3 CURSOR (i_cid TEXT, i_ym TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
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
                api, dispnum, SUM(total) AS total, MIN(ym) AS min_ym, MAX(ym) AS max_ym, SUM(hh00) AS hh00, SUM(hh01) AS hh01, SUM(hh02) AS hh02, SUM(hh03) AS hh03, SUM(hh04) AS hh04, SUM(hh05) AS hh05, SUM(hh06) AS hh06, SUM(hh07) AS hh07, SUM(hh08) AS hh08, SUM(hh09) AS hh09, SUM(hh10) AS hh10, SUM(hh11) AS hh11, SUM(hh12) AS hh12, SUM(hh13) AS hh13, SUM(hh14) AS hh14, SUM(hh15) AS hh15, SUM(hh16) AS hh16, SUM(hh17) AS hh17, SUM(hh18) AS hh18, SUM(hh19) AS hh19, SUM(hh20) AS hh20, SUM(hh21) AS hh21, SUM(hh22) AS hh22, SUM(hh23) AS hh23, 24 AS sum_cnt
                FROM (SELECT
                    b.column_value, b.api, b.dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') AS ym, '全体' AS api, 1 AS dispnum, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0
                        /* and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') BETWEEN COALESCE(aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_ym, 'yyyymm'), - 2), 'yyyymm'), aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.SYSDATE(), - 2), 'yyyymm')) AND COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm')) AS a, (SELECT
                        ym, '全体' AS api, 1 AS dispnum) AS b
                    WHERE a.api = b.api AND a.ym = b.column_value) AS var_sbq
                GROUP BY api, dispnum) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* サマリー、１ヶ月検索用カーソル */
    /* */;
    log_cur_s_1 CURSOR (i_cid TEXT, i_ym TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
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
                func_grp_name, grp_dispnum, SUM(total) AS total, MIN(ym) AS min_ym, MAX(ym) AS max_ym, SUM(hh00) AS hh00, SUM(hh01) AS hh01, SUM(hh02) AS hh02, SUM(hh03) AS hh03, SUM(hh04) AS hh04, SUM(hh05) AS hh05, SUM(hh06) AS hh06, SUM(hh07) AS hh07, SUM(hh08) AS hh08, SUM(hh09) AS hh09, SUM(hh10) AS hh10, SUM(hh11) AS hh11, SUM(hh12) AS hh12, SUM(hh13) AS hh13, SUM(hh14) AS hh14, SUM(hh15) AS hh15, SUM(hh16) AS hh16, SUM(hh17) AS hh17, SUM(hh18) AS hh18, SUM(hh19) AS hh19, SUM(hh20) AS hh20, SUM(hh21) AS hh21, SUM(hh22) AS hh22, SUM(hh23) AS hh23, 24 AS sum_cnt
                FROM (SELECT
                    b.ym, b.func_grp_name, b.grp_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') AS ym, m.func_grp_name AS api, m.grp_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        /* and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm'), m.func_grp_name, m.grp_dispnum) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        i_ym AS ym, m.func_grp_name AS api, m.grp_dispnum AS dispnum
                        FROM api20log.api20_mst AS m) AS b
                        ON (a.func_grp_name = b.func_grp_name)
                    WHERE a.ym = b.ym) AS var_sbq_2
                GROUP BY api, dispnum) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* サマリー、３ヶ月検索用カーソル */
    /* */;
    log_cur_s_3 CURSOR (i_cid TEXT, i_ym TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
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
                func_grp_name, grp_dispnum, SUM(total) AS total, MIN(ym) AS min_ym, MAX(ym) AS max_ym, SUM(hh00) AS hh00, SUM(hh01) AS hh01, SUM(hh02) AS hh02, SUM(hh03) AS hh03, SUM(hh04) AS hh04, SUM(hh05) AS hh05, SUM(hh06) AS hh06, SUM(hh07) AS hh07, SUM(hh08) AS hh08, SUM(hh09) AS hh09, SUM(hh10) AS hh10, SUM(hh11) AS hh11, SUM(hh12) AS hh12, SUM(hh13) AS hh13, SUM(hh14) AS hh14, SUM(hh15) AS hh15, SUM(hh16) AS hh16, SUM(hh17) AS hh17, SUM(hh18) AS hh18, SUM(hh19) AS hh19, SUM(hh20) AS hh20, SUM(hh21) AS hh21, SUM(hh22) AS hh22, SUM(hh23) AS hh23, 24 AS sum_cnt
                FROM (SELECT
                    b.column_value, b.func_grp_name, b.grp_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') AS ym, m.func_grp_name AS api, m.grp_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0
                        /* and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') BETWEEN COALESCE(aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_ym, 'yyyymm'), - 2), 'yyyymm'), aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.SYSDATE(), - 2), 'yyyymm')) AND COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm'), m.func_grp_name, m.grp_dispnum) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        ym, m.func_grp_name AS api, m.grp_dispnum AS dispnum
                        FROM api20log.api20_mst AS m, (SELECT
                            column_value AS ym
                            FROM aws_oracle_ext.table(pVal => api20log.f_ym_tbl_func(COALESCE(aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_ym, 'yyyymm'), - 2), 'yyyymm'), aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.SYSDATE(), - 2), 'yyyymm')), COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))), pValType => 'NESTED', pTypeToCast => 'api20log.ym_tbl_type$c')
                                AS (t api20log.ym_tbl_type$c)) AS var_sbq_3) AS b
                        ON (a.func_grp_name = b.func_grp_name AND a.ym = b.column_value)) AS var_sbq_4
                GROUP BY api, dispnum) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 機能グループ名、１ヶ月検索用カーソル */
    /* */;
    log_cur_g_1 CURSOR (i_cid TEXT, i_grp TEXT, i_ym TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
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
                func_name, func_dispnum, SUM(total) AS total, MIN(ym) AS min_ym, MAX(ym) AS max_ym, SUM(hh00) AS hh00, SUM(hh01) AS hh01, SUM(hh02) AS hh02, SUM(hh03) AS hh03, SUM(hh04) AS hh04, SUM(hh05) AS hh05, SUM(hh06) AS hh06, SUM(hh07) AS hh07, SUM(hh08) AS hh08, SUM(hh09) AS hh09, SUM(hh10) AS hh10, SUM(hh11) AS hh11, SUM(hh12) AS hh12, SUM(hh13) AS hh13, SUM(hh14) AS hh14, SUM(hh15) AS hh15, SUM(hh16) AS hh16, SUM(hh17) AS hh17, SUM(hh18) AS hh18, SUM(hh19) AS hh19, SUM(hh20) AS hh20, SUM(hh21) AS hh21, SUM(hh22) AS hh22, SUM(hh23) AS hh23, 24 AS sum_cnt
                FROM (SELECT
                    b.ym, b.func_name, b.func_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') AS ym, m.func_name AS api, m.func_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_grp
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_grp, m.func_grp_name)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        /* and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm'), m.func_name, m.func_dispnum) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        i_ym AS ym, m.func_name AS api, m.func_dispnum AS dispnum
                        FROM api20log.api20_mst AS m
                        WHERE m.func_grp_name = i_grp) AS b
                        ON (a.func_name = b.func_name)
                    WHERE a.ym = b.ym) AS var_sbq_5
                GROUP BY api, dispnum) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 機能グループ名、３ヶ月検索用カーソル */
    /* */;
    log_cur_g_3 CURSOR (i_cid TEXT, i_grp TEXT, i_ym TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
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
                func_name, func_dispnum, SUM(total) AS total, MIN(ym) AS min_ym, MAX(ym) AS max_ym, SUM(hh00) AS hh00, SUM(hh01) AS hh01, SUM(hh02) AS hh02, SUM(hh03) AS hh03, SUM(hh04) AS hh04, SUM(hh05) AS hh05, SUM(hh06) AS hh06, SUM(hh07) AS hh07, SUM(hh08) AS hh08, SUM(hh09) AS hh09, SUM(hh10) AS hh10, SUM(hh11) AS hh11, SUM(hh12) AS hh12, SUM(hh13) AS hh13, SUM(hh14) AS hh14, SUM(hh15) AS hh15, SUM(hh16) AS hh16, SUM(hh17) AS hh17, SUM(hh18) AS hh18, SUM(hh19) AS hh19, SUM(hh20) AS hh20, SUM(hh21) AS hh21, SUM(hh22) AS hh22, SUM(hh23) AS hh23, 24 AS sum_cnt
                FROM (SELECT
                    b.column_value, b.func_name, b.func_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') AS ym, m.func_name AS api, m.func_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_grp
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_grp, m.func_grp_name)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0
                        /* and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') BETWEEN COALESCE(aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_ym, 'yyyymm'), - 2), 'yyyymm'), aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.SYSDATE(), - 2), 'yyyymm')) AND COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm'), m.func_name, m.func_dispnum) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        ym, m.func_name AS api, m.func_dispnum AS dispnum
                        FROM api20log.api20_mst AS m, (SELECT
                            column_value AS ym
                            FROM aws_oracle_ext.table(pVal => api20log.f_ym_tbl_func(COALESCE(aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_ym, 'yyyymm'), - 2), 'yyyymm'), aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.SYSDATE(), - 2), 'yyyymm')), COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))), pValType => 'NESTED', pTypeToCast => 'api20log.ym_tbl_type$c')
                                AS (t api20log.ym_tbl_type$c)) AS var_sbq_6
                        WHERE m.func_grp_name = i_grp) AS b
                        ON (a.func_name = b.func_name AND a.ym = b.column_value)) AS var_sbq_7
                GROUP BY api, dispnum) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 機能名、１ヶ月検索用カーソル */
    /* */;
    log_cur_f_1 CURSOR (i_cid TEXT, i_grp TEXT, i_ym TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
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
                func_name, func_dispnum, SUM(total) AS total, MIN(ym) AS min_ym, MAX(ym) AS max_ym, SUM(hh00) AS hh00, SUM(hh01) AS hh01, SUM(hh02) AS hh02, SUM(hh03) AS hh03, SUM(hh04) AS hh04, SUM(hh05) AS hh05, SUM(hh06) AS hh06, SUM(hh07) AS hh07, SUM(hh08) AS hh08, SUM(hh09) AS hh09, SUM(hh10) AS hh10, SUM(hh11) AS hh11, SUM(hh12) AS hh12, SUM(hh13) AS hh13, SUM(hh14) AS hh14, SUM(hh15) AS hh15, SUM(hh16) AS hh16, SUM(hh17) AS hh17, SUM(hh18) AS hh18, SUM(hh19) AS hh19, SUM(hh20) AS hh20, SUM(hh21) AS hh21, SUM(hh22) AS hh22, SUM(hh23) AS hh23, 24 AS sum_cnt
                FROM (SELECT
                    b.ym, b.func_name, b.func_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') AS ym, m.func_name AS api, m.func_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_grp
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_grp, m.func_name)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        /* and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm'), m.func_name, m.func_dispnum) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        i_ym AS ym, m.func_name AS api, m.func_dispnum AS dispnum
                        FROM api20log.api20_mst AS m
                        WHERE m.func_name = i_grp) AS b
                        ON (a.func_name = b.func_name)
                    WHERE a.ym = b.ym) AS var_sbq_8
                GROUP BY api, dispnum) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 機能名、３ヶ月検索用カーソル */
    /* */;
    log_cur_f_3 CURSOR (i_cid TEXT, i_grp TEXT, i_ym TEXT, i_ssl TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
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
                func_name, func_dispnum, SUM(total) AS total, MIN(ym) AS min_ym, MAX(ym) AS max_ym, SUM(hh00) AS hh00, SUM(hh01) AS hh01, SUM(hh02) AS hh02, SUM(hh03) AS hh03, SUM(hh04) AS hh04, SUM(hh05) AS hh05, SUM(hh06) AS hh06, SUM(hh07) AS hh07, SUM(hh08) AS hh08, SUM(hh09) AS hh09, SUM(hh10) AS hh10, SUM(hh11) AS hh11, SUM(hh12) AS hh12, SUM(hh13) AS hh13, SUM(hh14) AS hh14, SUM(hh15) AS hh15, SUM(hh16) AS hh16, SUM(hh17) AS hh17, SUM(hh18) AS hh18, SUM(hh19) AS hh19, SUM(hh20) AS hh20, SUM(hh21) AS hh21, SUM(hh22) AS hh22, SUM(hh23) AS hh23, 24 AS sum_cnt
                FROM (SELECT
                    b.column_value, b.func_name, b.func_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.hh00, 0) AS hh00, COALESCE(a.hh01, 0) AS hh01, COALESCE(a.hh02, 0) AS hh02, COALESCE(a.hh03, 0) AS hh03, COALESCE(a.hh04, 0) AS hh04, COALESCE(a.hh05, 0) AS hh05, COALESCE(a.hh06, 0) AS hh06, COALESCE(a.hh07, 0) AS hh07, COALESCE(a.hh08, 0) AS hh08, COALESCE(a.hh09, 0) AS hh09, COALESCE(a.hh10, 0) AS hh10, COALESCE(a.hh11, 0) AS hh11, COALESCE(a.hh12, 0) AS hh12, COALESCE(a.hh13, 0) AS hh13, COALESCE(a.hh14, 0) AS hh14, COALESCE(a.hh15, 0) AS hh15, COALESCE(a.hh16, 0) AS hh16, COALESCE(a.hh17, 0) AS hh17, COALESCE(a.hh18, 0) AS hh18, COALESCE(a.hh19, 0) AS hh19, COALESCE(a.hh20, 0) AS hh20, COALESCE(a.hh21, 0) AS hh21, COALESCE(a.hh22, 0) AS hh22, COALESCE(a.hh23, 0) AS hh23
                    FROM (SELECT
                        aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') AS ym, m.func_name AS api, m.func_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, SUM(COALESCE(l.hh00, 0)) AS hh00, SUM(COALESCE(l.hh01, 0)) AS hh01, SUM(COALESCE(l.hh02, 0)) AS hh02, SUM(COALESCE(l.hh03, 0)) AS hh03, SUM(COALESCE(l.hh04, 0)) AS hh04, SUM(COALESCE(l.hh05, 0)) AS hh05, SUM(COALESCE(l.hh06, 0)) AS hh06, SUM(COALESCE(l.hh07, 0)) AS hh07, SUM(COALESCE(l.hh08, 0)) AS hh08, SUM(COALESCE(l.hh09, 0)) AS hh09, SUM(COALESCE(l.hh10, 0)) AS hh10, SUM(COALESCE(l.hh11, 0)) AS hh11, SUM(COALESCE(l.hh12, 0)) AS hh12, SUM(COALESCE(l.hh13, 0)) AS hh13, SUM(COALESCE(l.hh14, 0)) AS hh14, SUM(COALESCE(l.hh15, 0)) AS hh15, SUM(COALESCE(l.hh16, 0)) AS hh16, SUM(COALESCE(l.hh17, 0)) AS hh17, SUM(COALESCE(l.hh18, 0)) AS hh18, SUM(COALESCE(l.hh19, 0)) AS hh19, SUM(COALESCE(l.hh20, 0)) AS hh20, SUM(COALESCE(l.hh21, 0)) AS hh21, SUM(COALESCE(l.hh22, 0)) AS hh22, SUM(COALESCE(l.hh23, 0)) AS hh23
                        FROM api20log.api20_time_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_grp
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_grp, m.func_name)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0
                        /* and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        AND aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm') BETWEEN COALESCE(aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_ym, 'yyyymm'), - 2), 'yyyymm'), aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.SYSDATE(), - 2), 'yyyymm')) AND COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        GROUP BY aws_oracle_ext.TO_CHAR(l.ymd, 'yyyymm'), m.func_name, m.func_dispnum) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        ym, m.func_name AS api, m.func_dispnum AS dispnum
                        FROM api20log.api20_mst AS m, (SELECT
                            column_value AS ym
                            FROM aws_oracle_ext.table(pVal => api20log.f_ym_tbl_func(COALESCE(aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_ym, 'yyyymm'), - 2), 'yyyymm'), aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.SYSDATE(), - 2), 'yyyymm')), COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))), pValType => 'NESTED', pTypeToCast => 'api20log.ym_tbl_type$c')
                                AS (t api20log.ym_tbl_type$c)) AS var_sbq_9
                        WHERE m.func_name = i_grp) AS b
                        ON (a.func_name = b.func_name AND a.ym = b.column_value)) AS var_sbq_10
                GROUP BY api, dispnum) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* ワーク変数 */;
    w_cnt INTEGER;
    w_msg CHARACTER VARYING(500);
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20log.p_api_log_pkg$p_get_time');
    o_rtncd := 0;
    o_cnt := 0;
    CASE i_kbn
        WHEN 'T' THEN
            IF i_month = '1'
            /* データ取得 */
            THEN
                w_cnt := 0;

                FOR log_rec IN log_cur_t_1 (i_cid, api20log.chg_ym(i_ym), i_ssl, i_pos, i_cnt) LOOP
                    w_cnt := w_cnt + 1;
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                    o_cnt := log_rec.all_cnt;
                    o_min_ym := log_rec.min_ym;
                    o_max_ym := log_rec.max_ym;
                    o_gokei := log_rec.gokei;
                    o_avg := log_rec.avg_cnt;
                END LOOP;
            /* データ取得 */
            ELSE
                w_cnt := 0;

                FOR log_rec IN log_cur_t_3 (i_cid, api20log.chg_ym(i_ym), i_ssl, i_pos, i_cnt) LOOP
                    w_cnt := w_cnt + 1;
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                    o_cnt := log_rec.all_cnt;
                    o_min_ym := log_rec.min_ym;
                    o_max_ym := log_rec.max_ym;
                    o_gokei := log_rec.gokei;
                    o_avg := log_rec.avg_cnt;
                END LOOP;
            END IF;
        WHEN 'S' THEN
            IF i_month = '1'
            /* データ取得 */
            THEN
                w_cnt := 0;

                FOR log_rec IN log_cur_s_1 (i_cid, api20log.chg_ym(i_ym), i_ssl, i_pos, i_cnt) LOOP
                    w_cnt := w_cnt + 1;
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                    o_cnt := log_rec.all_cnt;
                    o_min_ym := log_rec.min_ym;
                    o_max_ym := log_rec.max_ym;
                    o_gokei := log_rec.gokei;
                    o_avg := log_rec.avg_cnt;
                END LOOP;
            /* データ取得 */
            ELSE
                w_cnt := 0;

                FOR log_rec IN log_cur_s_3 (i_cid, api20log.chg_ym(i_ym), i_ssl, i_pos, i_cnt) LOOP
                    w_cnt := w_cnt + 1;
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                    o_cnt := log_rec.all_cnt;
                    o_min_ym := log_rec.min_ym;
                    o_max_ym := log_rec.max_ym;
                    o_gokei := log_rec.gokei;
                    o_avg := log_rec.avg_cnt;
                END LOOP;
            END IF;
        WHEN 'G' THEN
            IF i_month = '1'
            /* データ取得 */
            THEN
                w_cnt := 0;

                FOR log_rec IN log_cur_g_1 (i_cid, i_grp, api20log.chg_ym(i_ym), i_ssl, i_pos, i_cnt) LOOP
                    w_cnt := w_cnt + 1;
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                    o_cnt := log_rec.all_cnt;
                    o_min_ym := log_rec.min_ym;
                    o_max_ym := log_rec.max_ym;
                    o_gokei := log_rec.gokei;
                    o_avg := log_rec.avg_cnt;
                END LOOP;
            /* データ取得 */
            ELSE
                w_cnt := 0;

                FOR log_rec IN log_cur_g_3 (i_cid, i_grp, api20log.chg_ym(i_ym), i_ssl, i_pos, i_cnt) LOOP
                    w_cnt := w_cnt + 1;
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                    o_cnt := log_rec.all_cnt;
                    o_min_ym := log_rec.min_ym;
                    o_max_ym := log_rec.max_ym;
                    o_gokei := log_rec.gokei;
                    o_avg := log_rec.avg_cnt;
                END LOOP;
            END IF;
        WHEN 'F' THEN
            IF i_month = '1'
            /* データ取得 */
            THEN
                w_cnt := 0;

                FOR log_rec IN log_cur_f_1 (i_cid, i_grp, api20log.chg_ym(i_ym), i_ssl, i_pos, i_cnt) LOOP
                    w_cnt := w_cnt + 1;
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                    o_cnt := log_rec.all_cnt;
                    o_min_ym := log_rec.min_ym;
                    o_max_ym := log_rec.max_ym;
                    o_gokei := log_rec.gokei;
                    o_avg := log_rec.avg_cnt;
                END LOOP;
            /* データ取得 */
            ELSE
                w_cnt := 0;

                FOR log_rec IN log_cur_f_3 (i_cid, i_grp, api20log.chg_ym(i_ym), i_ssl, i_pos, i_cnt) LOOP
                    w_cnt := w_cnt + 1;
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_time', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', 'hh00', ':"', log_rec.hh00, '",', 'hh01', ':"', log_rec.hh01, '",', 'hh02', ':"', log_rec.hh02, '",', 'hh03', ':"', log_rec.hh03, '",', 'hh04', ':"', log_rec.hh04, '",', 'hh05', ':"', log_rec.hh05, '",', 'hh06', ':"', log_rec.hh06, '",', 'hh07', ':"', log_rec.hh07, '",', 'hh08', ':"', log_rec.hh08, '",', 'hh09', ':"', log_rec.hh09, '",', 'hh10', ':"', log_rec.hh10, '",', 'hh11', ':"', log_rec.hh11, '",', 'hh12', ':"', log_rec.hh12, '",', 'hh13', ':"', log_rec.hh13, '",', 'hh14', ':"', log_rec.hh14, '",', 'hh15', ':"', log_rec.hh15, '",', 'hh16', ':"', log_rec.hh16, '",', 'hh17', ':"', log_rec.hh17, '",', 'hh18', ':"', log_rec.hh18, '",', 'hh19', ':"', log_rec.hh19, '",', 'hh20', ':"', log_rec.hh20, '",', 'hh21', ':"', log_rec.hh21, '",', 'hh22', ':"', log_rec.hh22, '",', 'hh23', ':"', log_rec.hh23, '"'));
                    o_cnt := log_rec.all_cnt;
                    o_min_ym := log_rec.min_ym;
                    o_max_ym := log_rec.max_ym;
                    o_gokei := log_rec.gokei;
                    o_avg := log_rec.avg_cnt;
                END LOOP;
            END IF;
        ELSE
            NULL;
    END CASE;
    o_rtncd := 0
    /* 正常終了 */;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20log.p_api_log_pkg$p_get_time', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20log.p_api_log_pkg$p_get_time');
    EXCEPTION
        WHEN others THEN
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg := substrb(sqlerrm, 1, 500)
            */
            /* insert into error_log values(sysdate, 'P_GET_TIME', i_cid, w_msg); */
            /* commit; */
            o_rtncd := 7000;
END;
$BODY$
LANGUAGE  plpgsql;