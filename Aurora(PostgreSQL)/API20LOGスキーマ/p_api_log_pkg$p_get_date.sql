CREATE OR REPLACE FUNCTION api20log.p_api_log_pkg$p_get_date(IN i_cid TEXT, IN i_kbn TEXT, IN i_month TEXT, IN i_ym TEXT, IN i_grp TEXT, IN i_ssl TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_rtncd DOUBLE PRECISION, OUT o_cnt DOUBLE PRECISION, OUT o_min_ym TEXT, OUT o_max_ym TEXT, OUT o_gokei DOUBLE PRECISION, OUT o_avg DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
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
                api, dispnum, ym, total, min_ym, max_ym, aws_oracle_ext.TO_NUMBER(aws_oracle_ext.TO_CHAR(aws_oracle_ext.LAST_DAY(aws_oracle_ext.TO_DATE(ym, 'YYYYMM')), 'dd')) AS sum_cnt, api20log.get_dd(ym, dd01, dd02, dd03, dd04, dd05, dd06, dd07, dd08, dd09, dd10, dd11, dd12, dd13, dd14, dd15, dd16, dd17, dd18, dd19, dd20, dd21, dd22, dd23, dd24, dd25, dd26, dd27, dd28, dd29, dd30, dd31) AS dd_info
                FROM (SELECT
                    COALESCE(a.ym, i_ym) AS ym, b.api, b.dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.min_ym, i_ym) AS min_ym, COALESCE(a.max_ym, i_ym) AS max_ym, COALESCE(a.dd01, 0) AS dd01, COALESCE(a.dd02, 0) AS dd02, COALESCE(a.dd03, 0) AS dd03, COALESCE(a.dd04, 0) AS dd04, COALESCE(a.dd05, 0) AS dd05, COALESCE(a.dd06, 0) AS dd06, COALESCE(a.dd07, 0) AS dd07, COALESCE(a.dd08, 0) AS dd08, COALESCE(a.dd09, 0) AS dd09, COALESCE(a.dd10, 0) AS dd10, COALESCE(a.dd11, 0) AS dd11, COALESCE(a.dd12, 0) AS dd12, COALESCE(a.dd13, 0) AS dd13, COALESCE(a.dd14, 0) AS dd14, COALESCE(a.dd15, 0) AS dd15, COALESCE(a.dd16, 0) AS dd16, COALESCE(a.dd17, 0) AS dd17, COALESCE(a.dd18, 0) AS dd18, COALESCE(a.dd19, 0) AS dd19, COALESCE(a.dd20, 0) AS dd20, COALESCE(a.dd21, 0) AS dd21, COALESCE(a.dd22, 0) AS dd22, COALESCE(a.dd23, 0) AS dd23, COALESCE(a.dd24, 0) AS dd24, COALESCE(a.dd25, 0) AS dd25, COALESCE(a.dd26, 0) AS dd26, COALESCE(a.dd27, 0) AS dd27, COALESCE(a.dd28, 0) AS dd28, COALESCE(a.dd29, 0) AS dd29, COALESCE(a.dd30, 0) AS dd30, COALESCE(a.dd31, 0) AS dd31
                    FROM (SELECT
                        l.ym, '全体' AS api, 1 AS dispnum, SUM(COALESCE(l.total, 0)) AS total, MIN(l.ym) AS min_ym, MAX(l.ym) AS max_ym, SUM(COALESCE(l.dd01, 0)) AS dd01, SUM(COALESCE(l.dd02, 0)) AS dd02, SUM(COALESCE(l.dd03, 0)) AS dd03, SUM(COALESCE(l.dd04, 0)) AS dd04, SUM(COALESCE(l.dd05, 0)) AS dd05, SUM(COALESCE(l.dd06, 0)) AS dd06, SUM(COALESCE(l.dd07, 0)) AS dd07, SUM(COALESCE(l.dd08, 0)) AS dd08, SUM(COALESCE(l.dd09, 0)) AS dd09, SUM(COALESCE(l.dd10, 0)) AS dd10, SUM(COALESCE(l.dd11, 0)) AS dd11, SUM(COALESCE(l.dd12, 0)) AS dd12, SUM(COALESCE(l.dd13, 0)) AS dd13, SUM(COALESCE(l.dd14, 0)) AS dd14, SUM(COALESCE(l.dd15, 0)) AS dd15, SUM(COALESCE(l.dd16, 0)) AS dd16, SUM(COALESCE(l.dd17, 0)) AS dd17, SUM(COALESCE(l.dd18, 0)) AS dd18, SUM(COALESCE(l.dd19, 0)) AS dd19, SUM(COALESCE(l.dd20, 0)) AS dd20, SUM(COALESCE(l.dd21, 0)) AS dd21, SUM(COALESCE(l.dd22, 0)) AS dd22, SUM(COALESCE(l.dd23, 0)) AS dd23, SUM(COALESCE(l.dd24, 0)) AS dd24, SUM(COALESCE(l.dd25, 0)) AS dd25, SUM(COALESCE(l.dd26, 0)) AS dd26, SUM(COALESCE(l.dd27, 0)) AS dd27, SUM(COALESCE(l.dd28, 0)) AS dd28, SUM(COALESCE(l.dd29, 0)) AS dd29, SUM(COALESCE(l.dd30, 0)) AS dd30, SUM(COALESCE(l.dd31, 0)) AS dd31
                        FROM api20log.api20_date_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND ym = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        /* and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        GROUP BY l.ym) AS a, (SELECT
                        '全体' AS api, 1 AS dispnum) AS b
                    WHERE a.api = b.api) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 全体、３ヶ月検索用カーソル */
    /* */
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the LISTAGG(<DYNAMIC_TYPE>,VARCHAR2) function. Use suitable function or create user defined function., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    cursor log_cur_t_3 (
        i_cid		in	varchar2,
        i_ym		in	varchar2,
        i_ssl		in	varchar2,
        i_pos		in	number,
        i_cnt		in	number
      ) is
        select p.*,
               round(sum_total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
               round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
          select api, dispnum, min_ym, max_ym, sum_total, sum_cnt, dd_info,
                 count(*) over () all_cnt,
                 sum(sum_total) over() gokei,
                 row_number() over (order by dispnum) rnum
          from (select api, dispnum,
                 min(ym) min_ym,
                 max(ym) max_ym,
                 sum(total) sum_total,
                 sum(sum_cnt) sum_cnt,
                 listagg(dd_info, ',') within group (order by ym) dd_info
            from (select t.ym, t.api, t.dispnum,
                         nvl(sum_cnt, 0) sum_cnt,
                         nvl(total, 0) total,
                         get_dd(t.ym, nvl(dd01, 0), nvl(dd02, 0), nvl(dd03, 0), nvl(dd04, 0), nvl(dd05, 0), nvl(dd06, 0), nvl(dd07, 0), nvl(dd08, 0), nvl(dd09, 0), nvl(dd10, 0),
                                      nvl(dd11, 0), nvl(dd12, 0), nvl(dd13, 0), nvl(dd14, 0), nvl(dd15, 0), nvl(dd16, 0), nvl(dd17, 0), nvl(dd18, 0), nvl(dd19, 0), nvl(dd20, 0),
                                      nvl(dd21, 0), nvl(dd22, 0), nvl(dd23, 0), nvl(dd24, 0), nvl(dd25, 0), nvl(dd26, 0), nvl(dd27, 0), nvl(dd28, 0), nvl(dd29, 0), nvl(dd30, 0), nvl(dd31, 0)) dd_info
              from (select l.ym, '全体' api, 1 dispnum, sum(nvl(l.total, 0)) total,
                           to_number(to_char(last_day(to_date(l.ym, 'YYYYMM')), 'dd')) sum_cnt,
                           sum(nvl(l.dd01, 0)) dd01,sum(nvl(l.dd02, 0)) dd02,sum(nvl(l.dd03, 0)) dd03,sum(nvl(l.dd04, 0)) dd04,sum(nvl(l.dd05, 0)) dd05,
                           sum(nvl(l.dd06, 0)) dd06,sum(nvl(l.dd07, 0)) dd07,sum(nvl(l.dd08, 0)) dd08,sum(nvl(l.dd09, 0)) dd09,sum(nvl(l.dd10, 0)) dd10,
                           sum(nvl(l.dd11, 0)) dd11,sum(nvl(l.dd12, 0)) dd12,sum(nvl(l.dd13, 0)) dd13,sum(nvl(l.dd14, 0)) dd14,sum(nvl(l.dd15, 0)) dd15,
                           sum(nvl(l.dd16, 0)) dd16,sum(nvl(l.dd17, 0)) dd17,sum(nvl(l.dd18, 0)) dd18,sum(nvl(l.dd19, 0)) dd19,sum(nvl(l.dd20, 0)) dd20,
                           sum(nvl(l.dd21, 0)) dd21,sum(nvl(l.dd22, 0)) dd22,sum(nvl(l.dd23, 0)) dd23,sum(nvl(l.dd24, 0)) dd24,sum(nvl(l.dd25, 0)) dd25,
                           sum(nvl(l.dd26, 0)) dd26,sum(nvl(l.dd27, 0)) dd27,sum(nvl(l.dd28, 0)) dd28,sum(nvl(l.dd29, 0)) dd29,sum(nvl(l.dd30, 0)) dd30,
                           sum(nvl(l.dd31, 0)) dd31
                from api20_date_log l, api20_mst m
                where l.api = m.api
                  and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
                  and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
                  -- and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
                  and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
                group by l.ym
              ) l,
              (select ym, api, dispnum from (
                 select '全体' api, 1 dispnum
                 from dual m) a,
                 (select column_value ym from table(f_ym_tbl_func(nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')), nvl(i_ym, to_char(sysdate,'yyyymm')))))) t
              where l.ym(+) = t.ym
                and l.api(+) = t.api
                and l.dispnum(+) = t.dispnum
            )
            group by api, dispnum
          ) o
        ) p
        where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
        order by rnum
    */
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
                func_grp_name, grp_dispnum, ym, total, min_ym, max_ym, aws_oracle_ext.TO_NUMBER(aws_oracle_ext.TO_CHAR(aws_oracle_ext.LAST_DAY(aws_oracle_ext.TO_DATE(ym, 'YYYYMM')), 'dd')) AS sum_cnt, api20log.get_dd(ym, dd01, dd02, dd03, dd04, dd05, dd06, dd07, dd08, dd09, dd10, dd11, dd12, dd13, dd14, dd15, dd16, dd17, dd18, dd19, dd20, dd21, dd22, dd23, dd24, dd25, dd26, dd27, dd28, dd29, dd30, dd31) AS dd_info
                FROM (SELECT
                    COALESCE(a.ym, i_ym) AS ym, b.func_grp_name, b.grp_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.min_ym, i_ym) AS min_ym, COALESCE(a.max_ym, i_ym) AS max_ym, COALESCE(a.dd01, 0) AS dd01, COALESCE(a.dd02, 0) AS dd02, COALESCE(a.dd03, 0) AS dd03, COALESCE(a.dd04, 0) AS dd04, COALESCE(a.dd05, 0) AS dd05, COALESCE(a.dd06, 0) AS dd06, COALESCE(a.dd07, 0) AS dd07, COALESCE(a.dd08, 0) AS dd08, COALESCE(a.dd09, 0) AS dd09, COALESCE(a.dd10, 0) AS dd10, COALESCE(a.dd11, 0) AS dd11, COALESCE(a.dd12, 0) AS dd12, COALESCE(a.dd13, 0) AS dd13, COALESCE(a.dd14, 0) AS dd14, COALESCE(a.dd15, 0) AS dd15, COALESCE(a.dd16, 0) AS dd16, COALESCE(a.dd17, 0) AS dd17, COALESCE(a.dd18, 0) AS dd18, COALESCE(a.dd19, 0) AS dd19, COALESCE(a.dd20, 0) AS dd20, COALESCE(a.dd21, 0) AS dd21, COALESCE(a.dd22, 0) AS dd22, COALESCE(a.dd23, 0) AS dd23, COALESCE(a.dd24, 0) AS dd24, COALESCE(a.dd25, 0) AS dd25, COALESCE(a.dd26, 0) AS dd26, COALESCE(a.dd27, 0) AS dd27, COALESCE(a.dd28, 0) AS dd28, COALESCE(a.dd29, 0) AS dd29, COALESCE(a.dd30, 0) AS dd30, COALESCE(a.dd31, 0) AS dd31
                    FROM (SELECT
                        l.ym, m.func_grp_name AS api, m.grp_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, MIN(l.ym) AS min_ym, MAX(l.ym) AS max_ym, SUM(COALESCE(l.dd01, 0)) AS dd01, SUM(COALESCE(l.dd02, 0)) AS dd02, SUM(COALESCE(l.dd03, 0)) AS dd03, SUM(COALESCE(l.dd04, 0)) AS dd04, SUM(COALESCE(l.dd05, 0)) AS dd05, SUM(COALESCE(l.dd06, 0)) AS dd06, SUM(COALESCE(l.dd07, 0)) AS dd07, SUM(COALESCE(l.dd08, 0)) AS dd08, SUM(COALESCE(l.dd09, 0)) AS dd09, SUM(COALESCE(l.dd10, 0)) AS dd10, SUM(COALESCE(l.dd11, 0)) AS dd11, SUM(COALESCE(l.dd12, 0)) AS dd12, SUM(COALESCE(l.dd13, 0)) AS dd13, SUM(COALESCE(l.dd14, 0)) AS dd14, SUM(COALESCE(l.dd15, 0)) AS dd15, SUM(COALESCE(l.dd16, 0)) AS dd16, SUM(COALESCE(l.dd17, 0)) AS dd17, SUM(COALESCE(l.dd18, 0)) AS dd18, SUM(COALESCE(l.dd19, 0)) AS dd19, SUM(COALESCE(l.dd20, 0)) AS dd20, SUM(COALESCE(l.dd21, 0)) AS dd21, SUM(COALESCE(l.dd22, 0)) AS dd22, SUM(COALESCE(l.dd23, 0)) AS dd23, SUM(COALESCE(l.dd24, 0)) AS dd24, SUM(COALESCE(l.dd25, 0)) AS dd25, SUM(COALESCE(l.dd26, 0)) AS dd26, SUM(COALESCE(l.dd27, 0)) AS dd27, SUM(COALESCE(l.dd28, 0)) AS dd28, SUM(COALESCE(l.dd29, 0)) AS dd29, SUM(COALESCE(l.dd30, 0)) AS dd30, SUM(COALESCE(l.dd31, 0)) AS dd31
                        FROM api20log.api20_date_log AS l, api20log.api20_mst AS m
                        WHERE l.api = m.api AND
                        CASE i_cid
                            WHEN NULL THEN 1
                            ELSE aws_oracle_ext.INSTR(i_cid, l.cid)
                        END != 0 AND
                        CASE i_ssl
                            WHEN 'T' THEN 1
                            ELSE aws_oracle_ext.INSTR(i_ssl, l.ssl)
                        END != 0 AND ym = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        /* and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        GROUP BY l.ym, m.func_grp_name, m.grp_dispnum) AS a
                    LEFT OUTER JOIN (SELECT DISTINCT
                        m.func_grp_name AS api, m.grp_dispnum AS dispnum
                        FROM api20log.api20_mst AS m) AS b
                        ON (a.func_grp_name = b.func_grp_name)) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* サマリー、３ヶ月検索用カーソル */
    /* */
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the LISTAGG(<DYNAMIC_TYPE>,VARCHAR2) function. Use suitable function or create user defined function., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    cursor log_cur_s_3 (
        i_cid		in	varchar2,
        i_ym		in	varchar2,
        i_ssl		in	varchar2,
        i_pos		in	number,
        i_cnt		in	number
      ) is
        select p.*,
               round(sum_total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
               round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
          select api, dispnum, min_ym, max_ym, sum_total, sum_cnt, dd_info,
                 count(*) over () all_cnt,
                 sum(sum_total) over() gokei,
                 row_number() over (order by dispnum) rnum
          from (select api, dispnum,
                 min(ym) min_ym,
                 max(ym) max_ym,
                 sum(total) sum_total,
                 sum(sum_cnt) sum_cnt,
                 listagg(dd_info, ',') within group (order by ym) dd_info
            from (select t.ym, t.api, t.dispnum,
                         nvl(sum_cnt, 0) sum_cnt,
                         nvl(total, 0) total,
                         get_dd(t.ym, nvl(dd01, 0), nvl(dd02, 0), nvl(dd03, 0), nvl(dd04, 0), nvl(dd05, 0), nvl(dd06, 0), nvl(dd07, 0), nvl(dd08, 0), nvl(dd09, 0), nvl(dd10, 0),
                                      nvl(dd11, 0), nvl(dd12, 0), nvl(dd13, 0), nvl(dd14, 0), nvl(dd15, 0), nvl(dd16, 0), nvl(dd17, 0), nvl(dd18, 0), nvl(dd19, 0), nvl(dd20, 0),
                                      nvl(dd21, 0), nvl(dd22, 0), nvl(dd23, 0), nvl(dd24, 0), nvl(dd25, 0), nvl(dd26, 0), nvl(dd27, 0), nvl(dd28, 0), nvl(dd29, 0), nvl(dd30, 0), nvl(dd31, 0)) dd_info
              from (select l.ym, m.func_grp_name api, m.grp_dispnum dispnum, sum(nvl(l.total, 0)) total,
                           to_number(to_char(last_day(to_date(l.ym, 'YYYYMM')), 'dd')) sum_cnt,
                           sum(nvl(l.dd01, 0)) dd01,sum(nvl(l.dd02, 0)) dd02,sum(nvl(l.dd03, 0)) dd03,sum(nvl(l.dd04, 0)) dd04,sum(nvl(l.dd05, 0)) dd05,
                           sum(nvl(l.dd06, 0)) dd06,sum(nvl(l.dd07, 0)) dd07,sum(nvl(l.dd08, 0)) dd08,sum(nvl(l.dd09, 0)) dd09,sum(nvl(l.dd10, 0)) dd10,
                           sum(nvl(l.dd11, 0)) dd11,sum(nvl(l.dd12, 0)) dd12,sum(nvl(l.dd13, 0)) dd13,sum(nvl(l.dd14, 0)) dd14,sum(nvl(l.dd15, 0)) dd15,
                           sum(nvl(l.dd16, 0)) dd16,sum(nvl(l.dd17, 0)) dd17,sum(nvl(l.dd18, 0)) dd18,sum(nvl(l.dd19, 0)) dd19,sum(nvl(l.dd20, 0)) dd20,
                           sum(nvl(l.dd21, 0)) dd21,sum(nvl(l.dd22, 0)) dd22,sum(nvl(l.dd23, 0)) dd23,sum(nvl(l.dd24, 0)) dd24,sum(nvl(l.dd25, 0)) dd25,
                           sum(nvl(l.dd26, 0)) dd26,sum(nvl(l.dd27, 0)) dd27,sum(nvl(l.dd28, 0)) dd28,sum(nvl(l.dd29, 0)) dd29,sum(nvl(l.dd30, 0)) dd30,
                           sum(nvl(l.dd31, 0)) dd31
                from api20_date_log l, api20_mst m
                where l.api = m.api
                  and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
                  and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
                  -- and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
                  and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
                group by l.ym, m.func_grp_name, m.grp_dispnum
              ) l,
              (select ym, api, dispnum from (
                 select m.func_grp_name api, m.grp_dispnum dispnum
                 from api20_mst m
                 group by m.func_grp_name, m.grp_dispnum) a,
                 (select column_value ym from table(f_ym_tbl_func(nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')), nvl(i_ym, to_char(sysdate,'yyyymm')))))) t
              where l.ym(+) = t.ym
                and l.api(+) = t.api
                and l.dispnum(+) = t.dispnum
            )
            group by api, dispnum
          ) o
        ) p
        where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
        order by rnum
    */
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
                func_name, func_dispnum, ym, total, min_ym, max_ym, aws_oracle_ext.TO_NUMBER(aws_oracle_ext.TO_CHAR(aws_oracle_ext.LAST_DAY(aws_oracle_ext.TO_DATE(ym, 'YYYYMM')), 'dd')) AS sum_cnt, api20log.get_dd(ym, dd01, dd02, dd03, dd04, dd05, dd06, dd07, dd08, dd09, dd10, dd11, dd12, dd13, dd14, dd15, dd16, dd17, dd18, dd19, dd20, dd21, dd22, dd23, dd24, dd25, dd26, dd27, dd28, dd29, dd30, dd31) AS dd_info
                FROM (SELECT
                    COALESCE(a.ym, i_ym) AS ym, b.func_name, b.func_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.min_ym, i_ym) AS min_ym, COALESCE(a.max_ym, i_ym) AS max_ym, COALESCE(a.dd01, 0) AS dd01, COALESCE(a.dd02, 0) AS dd02, COALESCE(a.dd03, 0) AS dd03, COALESCE(a.dd04, 0) AS dd04, COALESCE(a.dd05, 0) AS dd05, COALESCE(a.dd06, 0) AS dd06, COALESCE(a.dd07, 0) AS dd07, COALESCE(a.dd08, 0) AS dd08, COALESCE(a.dd09, 0) AS dd09, COALESCE(a.dd10, 0) AS dd10, COALESCE(a.dd11, 0) AS dd11, COALESCE(a.dd12, 0) AS dd12, COALESCE(a.dd13, 0) AS dd13, COALESCE(a.dd14, 0) AS dd14, COALESCE(a.dd15, 0) AS dd15, COALESCE(a.dd16, 0) AS dd16, COALESCE(a.dd17, 0) AS dd17, COALESCE(a.dd18, 0) AS dd18, COALESCE(a.dd19, 0) AS dd19, COALESCE(a.dd20, 0) AS dd20, COALESCE(a.dd21, 0) AS dd21, COALESCE(a.dd22, 0) AS dd22, COALESCE(a.dd23, 0) AS dd23, COALESCE(a.dd24, 0) AS dd24, COALESCE(a.dd25, 0) AS dd25, COALESCE(a.dd26, 0) AS dd26, COALESCE(a.dd27, 0) AS dd27, COALESCE(a.dd28, 0) AS dd28, COALESCE(a.dd29, 0) AS dd29, COALESCE(a.dd30, 0) AS dd30, COALESCE(a.dd31, 0) AS dd31
                    FROM (SELECT
                        l.ym, m.func_name AS api, m.func_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, MIN(l.ym) AS min_ym, MAX(l.ym) AS max_ym, SUM(COALESCE(l.dd01, 0)) AS dd01, SUM(COALESCE(l.dd02, 0)) AS dd02, SUM(COALESCE(l.dd03, 0)) AS dd03, SUM(COALESCE(l.dd04, 0)) AS dd04, SUM(COALESCE(l.dd05, 0)) AS dd05, SUM(COALESCE(l.dd06, 0)) AS dd06, SUM(COALESCE(l.dd07, 0)) AS dd07, SUM(COALESCE(l.dd08, 0)) AS dd08, SUM(COALESCE(l.dd09, 0)) AS dd09, SUM(COALESCE(l.dd10, 0)) AS dd10, SUM(COALESCE(l.dd11, 0)) AS dd11, SUM(COALESCE(l.dd12, 0)) AS dd12, SUM(COALESCE(l.dd13, 0)) AS dd13, SUM(COALESCE(l.dd14, 0)) AS dd14, SUM(COALESCE(l.dd15, 0)) AS dd15, SUM(COALESCE(l.dd16, 0)) AS dd16, SUM(COALESCE(l.dd17, 0)) AS dd17, SUM(COALESCE(l.dd18, 0)) AS dd18, SUM(COALESCE(l.dd19, 0)) AS dd19, SUM(COALESCE(l.dd20, 0)) AS dd20, SUM(COALESCE(l.dd21, 0)) AS dd21, SUM(COALESCE(l.dd22, 0)) AS dd22, SUM(COALESCE(l.dd23, 0)) AS dd23, SUM(COALESCE(l.dd24, 0)) AS dd24, SUM(COALESCE(l.dd25, 0)) AS dd25, SUM(COALESCE(l.dd26, 0)) AS dd26, SUM(COALESCE(l.dd27, 0)) AS dd27, SUM(COALESCE(l.dd28, 0)) AS dd28, SUM(COALESCE(l.dd29, 0)) AS dd29, SUM(COALESCE(l.dd30, 0)) AS dd30, SUM(COALESCE(l.dd31, 0)) AS dd31
                        FROM api20log.api20_date_log AS l, api20log.api20_mst AS m
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
                        END != 0 AND ym = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        /* and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        GROUP BY l.ym, m.func_name, m.func_dispnum) AS a
                    LEFT OUTER JOIN (SELECT
                        m.func_name AS api, m.func_dispnum AS dispnum
                        FROM api20log.api20_mst AS m
                        WHERE m.func_grp_name = i_grp) AS b
                        ON (a.func_name = b.func_name)) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 機能グループ名、３ヶ月検索用カーソル */
    /* */
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the LISTAGG(<DYNAMIC_TYPE>,VARCHAR2) function. Use suitable function or create user defined function., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    cursor log_cur_g_3 (
        i_cid		in	varchar2,
        i_grp		in	varchar2,
        i_ym		in	varchar2,
        i_ssl		in	varchar2,
        i_pos		in	number,
        i_cnt		in	number
      ) is
        select p.*,
               round(sum_total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
               round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
          select api, dispnum, min_ym, max_ym, sum_total, sum_cnt, dd_info,
                 count(*) over () all_cnt,
                 sum(sum_total) over() gokei,
                 row_number() over (order by dispnum) rnum
          from (select api, dispnum,
                 min(ym) min_ym,
                 max(ym) max_ym,
                 sum(total) sum_total,
                 sum(sum_cnt) sum_cnt,
                 listagg(dd_info, ',') within group (order by ym) dd_info
            from (select t.ym, t.api, t.dispnum,
                         nvl(sum_cnt, 0) sum_cnt,
                         nvl(total, 0) total,
                         get_dd(t.ym, nvl(dd01, 0), nvl(dd02, 0), nvl(dd03, 0), nvl(dd04, 0), nvl(dd05, 0), nvl(dd06, 0), nvl(dd07, 0), nvl(dd08, 0), nvl(dd09, 0), nvl(dd10, 0),
                                      nvl(dd11, 0), nvl(dd12, 0), nvl(dd13, 0), nvl(dd14, 0), nvl(dd15, 0), nvl(dd16, 0), nvl(dd17, 0), nvl(dd18, 0), nvl(dd19, 0), nvl(dd20, 0),
                                      nvl(dd21, 0), nvl(dd22, 0), nvl(dd23, 0), nvl(dd24, 0), nvl(dd25, 0), nvl(dd26, 0), nvl(dd27, 0), nvl(dd28, 0), nvl(dd29, 0), nvl(dd30, 0), nvl(dd31, 0)) dd_info
              from (select l.ym, m.func_name api, m.func_dispnum dispnum, sum(nvl(l.total, 0)) total,
                           to_number(to_char(last_day(to_date(l.ym, 'YYYYMM')), 'dd')) sum_cnt,
                           sum(nvl(l.dd01, 0)) dd01,sum(nvl(l.dd02, 0)) dd02,sum(nvl(l.dd03, 0)) dd03,sum(nvl(l.dd04, 0)) dd04,sum(nvl(l.dd05, 0)) dd05,
                           sum(nvl(l.dd06, 0)) dd06,sum(nvl(l.dd07, 0)) dd07,sum(nvl(l.dd08, 0)) dd08,sum(nvl(l.dd09, 0)) dd09,sum(nvl(l.dd10, 0)) dd10,
                           sum(nvl(l.dd11, 0)) dd11,sum(nvl(l.dd12, 0)) dd12,sum(nvl(l.dd13, 0)) dd13,sum(nvl(l.dd14, 0)) dd14,sum(nvl(l.dd15, 0)) dd15,
                           sum(nvl(l.dd16, 0)) dd16,sum(nvl(l.dd17, 0)) dd17,sum(nvl(l.dd18, 0)) dd18,sum(nvl(l.dd19, 0)) dd19,sum(nvl(l.dd20, 0)) dd20,
                           sum(nvl(l.dd21, 0)) dd21,sum(nvl(l.dd22, 0)) dd22,sum(nvl(l.dd23, 0)) dd23,sum(nvl(l.dd24, 0)) dd24,sum(nvl(l.dd25, 0)) dd25,
                           sum(nvl(l.dd26, 0)) dd26,sum(nvl(l.dd27, 0)) dd27,sum(nvl(l.dd28, 0)) dd28,sum(nvl(l.dd29, 0)) dd29,sum(nvl(l.dd30, 0)) dd30,
                           sum(nvl(l.dd31, 0)) dd31
                from api20_date_log l, api20_mst m
                where l.api = m.api
                  and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
                  and decode(i_grp, null, 1, instr(i_grp, m.func_grp_name)) != 0
                  and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
                  -- and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
                  and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
                group by l.ym, m.func_name, m.func_dispnum
              ) l,
              (select ym, api, dispnum from (
                 select m.func_name api, m.func_dispnum dispnum
                 from api20_mst m
                 where decode(i_grp, null, 1, instr(i_grp, m.func_grp_name)) != 0
                 group by m.func_name, m.func_dispnum) a,
                 (select column_value ym from table(f_ym_tbl_func(nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')), nvl(i_ym, to_char(sysdate,'yyyymm')))))) t
              where l.ym(+) = t.ym
                and l.api(+) = t.api
                and l.dispnum(+) = t.dispnum
            )
            group by api, dispnum
          ) o
        ) p
        where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
        order by rnum
    */
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
                func_name, func_dispnum, ym, total, min_ym, max_ym, aws_oracle_ext.TO_NUMBER(aws_oracle_ext.TO_CHAR(aws_oracle_ext.LAST_DAY(aws_oracle_ext.TO_DATE(ym, 'YYYYMM')), 'dd')) AS sum_cnt, api20log.get_dd(ym, dd01, dd02, dd03, dd04, dd05, dd06, dd07, dd08, dd09, dd10, dd11, dd12, dd13, dd14, dd15, dd16, dd17, dd18, dd19, dd20, dd21, dd22, dd23, dd24, dd25, dd26, dd27, dd28, dd29, dd30, dd31) AS dd_info
                FROM (SELECT
                    COALESCE(a.ym, i_ym) AS ym, b.func_name, b.func_dispnum, COALESCE(a.total, 0) AS total, COALESCE(a.min_ym, i_ym) AS min_ym, COALESCE(a.max_ym, i_ym) AS max_ym, COALESCE(a.dd01, 0) AS dd01, COALESCE(a.dd02, 0) AS dd02, COALESCE(a.dd03, 0) AS dd03, COALESCE(a.dd04, 0) AS dd04, COALESCE(a.dd05, 0) AS dd05, COALESCE(a.dd06, 0) AS dd06, COALESCE(a.dd07, 0) AS dd07, COALESCE(a.dd08, 0) AS dd08, COALESCE(a.dd09, 0) AS dd09, COALESCE(a.dd10, 0) AS dd10, COALESCE(a.dd11, 0) AS dd11, COALESCE(a.dd12, 0) AS dd12, COALESCE(a.dd13, 0) AS dd13, COALESCE(a.dd14, 0) AS dd14, COALESCE(a.dd15, 0) AS dd15, COALESCE(a.dd16, 0) AS dd16, COALESCE(a.dd17, 0) AS dd17, COALESCE(a.dd18, 0) AS dd18, COALESCE(a.dd19, 0) AS dd19, COALESCE(a.dd20, 0) AS dd20, COALESCE(a.dd21, 0) AS dd21, COALESCE(a.dd22, 0) AS dd22, COALESCE(a.dd23, 0) AS dd23, COALESCE(a.dd24, 0) AS dd24, COALESCE(a.dd25, 0) AS dd25, COALESCE(a.dd26, 0) AS dd26, COALESCE(a.dd27, 0) AS dd27, COALESCE(a.dd28, 0) AS dd28, COALESCE(a.dd29, 0) AS dd29, COALESCE(a.dd30, 0) AS dd30, COALESCE(a.dd31, 0) AS dd31
                    FROM (SELECT
                        l.ym, m.func_name AS api, m.func_dispnum AS dispnum, SUM(COALESCE(l.total, 0)) AS total, MIN(l.ym) AS min_ym, MAX(l.ym) AS max_ym, SUM(COALESCE(l.dd01, 0)) AS dd01, SUM(COALESCE(l.dd02, 0)) AS dd02, SUM(COALESCE(l.dd03, 0)) AS dd03, SUM(COALESCE(l.dd04, 0)) AS dd04, SUM(COALESCE(l.dd05, 0)) AS dd05, SUM(COALESCE(l.dd06, 0)) AS dd06, SUM(COALESCE(l.dd07, 0)) AS dd07, SUM(COALESCE(l.dd08, 0)) AS dd08, SUM(COALESCE(l.dd09, 0)) AS dd09, SUM(COALESCE(l.dd10, 0)) AS dd10, SUM(COALESCE(l.dd11, 0)) AS dd11, SUM(COALESCE(l.dd12, 0)) AS dd12, SUM(COALESCE(l.dd13, 0)) AS dd13, SUM(COALESCE(l.dd14, 0)) AS dd14, SUM(COALESCE(l.dd15, 0)) AS dd15, SUM(COALESCE(l.dd16, 0)) AS dd16, SUM(COALESCE(l.dd17, 0)) AS dd17, SUM(COALESCE(l.dd18, 0)) AS dd18, SUM(COALESCE(l.dd19, 0)) AS dd19, SUM(COALESCE(l.dd20, 0)) AS dd20, SUM(COALESCE(l.dd21, 0)) AS dd21, SUM(COALESCE(l.dd22, 0)) AS dd22, SUM(COALESCE(l.dd23, 0)) AS dd23, SUM(COALESCE(l.dd24, 0)) AS dd24, SUM(COALESCE(l.dd25, 0)) AS dd25, SUM(COALESCE(l.dd26, 0)) AS dd26, SUM(COALESCE(l.dd27, 0)) AS dd27, SUM(COALESCE(l.dd28, 0)) AS dd28, SUM(COALESCE(l.dd29, 0)) AS dd29, SUM(COALESCE(l.dd30, 0)) AS dd30, SUM(COALESCE(l.dd31, 0)) AS dd31
                        FROM api20log.api20_date_log AS l, api20log.api20_mst AS m
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
                        END != 0 AND ym = COALESCE(i_ym, aws_oracle_ext.TO_CHAR(aws_oracle_ext.SYSDATE(), 'yyyymm'))
                        /* and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm')) */
                        GROUP BY l.ym, m.func_name, m.func_dispnum) AS a
                    LEFT OUTER JOIN (SELECT
                        m.func_name AS api, m.func_dispnum AS dispnum
                        FROM api20log.api20_mst AS m
                        WHERE m.func_name = i_grp) AS b
                        ON (a.func_name = b.func_name)) AS l) AS o) AS p
        WHERE rnum BETWEEN COALESCE(i_pos, 1) AND (COALESCE(i_pos, 1) + COALESCE(i_cnt, 999999) - 1)
        ORDER BY rnum
    /* */
    /* 機能名、３ヶ月検索用カーソル */
    /* */
    /*
    [5340 - Severity CRITICAL - PostgreSQL doesn't support the LISTAGG(<DYNAMIC_TYPE>,VARCHAR2) function. Use suitable function or create user defined function., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    cursor log_cur_f_3 (
        i_cid		in	varchar2,
        i_grp		in	varchar2,
        i_ym		in	varchar2,
        i_ssl		in	varchar2,
        i_pos		in	number,
        i_cnt		in	number
      ) is
        select p.*,
               round(sum_total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
               round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
          select api, dispnum, min_ym, max_ym, sum_total, sum_cnt, dd_info,
                 count(*) over () all_cnt,
                 sum(sum_total) over() gokei,
                 row_number() over (order by dispnum) rnum
          from (select api, dispnum,
                 min(ym) min_ym,
                 max(ym) max_ym,
                 sum(total) sum_total,
                 sum(sum_cnt) sum_cnt,
                 listagg(dd_info, ',') within group (order by ym) dd_info
            from (select t.ym, t.api, t.dispnum,
                         nvl(sum_cnt, 0) sum_cnt,
                         nvl(total, 0) total,
                         get_dd(t.ym, nvl(dd01, 0), nvl(dd02, 0), nvl(dd03, 0), nvl(dd04, 0), nvl(dd05, 0), nvl(dd06, 0), nvl(dd07, 0), nvl(dd08, 0), nvl(dd09, 0), nvl(dd10, 0),
                                      nvl(dd11, 0), nvl(dd12, 0), nvl(dd13, 0), nvl(dd14, 0), nvl(dd15, 0), nvl(dd16, 0), nvl(dd17, 0), nvl(dd18, 0), nvl(dd19, 0), nvl(dd20, 0),
                                      nvl(dd21, 0), nvl(dd22, 0), nvl(dd23, 0), nvl(dd24, 0), nvl(dd25, 0), nvl(dd26, 0), nvl(dd27, 0), nvl(dd28, 0), nvl(dd29, 0), nvl(dd30, 0), nvl(dd31, 0)) dd_info
              from (select l.ym, m.func_name api, m.func_dispnum dispnum, sum(nvl(l.total, 0)) total,
                           to_number(to_char(last_day(to_date(l.ym, 'YYYYMM')), 'dd')) sum_cnt,
                           sum(nvl(l.dd01, 0)) dd01,sum(nvl(l.dd02, 0)) dd02,sum(nvl(l.dd03, 0)) dd03,sum(nvl(l.dd04, 0)) dd04,sum(nvl(l.dd05, 0)) dd05,
                           sum(nvl(l.dd06, 0)) dd06,sum(nvl(l.dd07, 0)) dd07,sum(nvl(l.dd08, 0)) dd08,sum(nvl(l.dd09, 0)) dd09,sum(nvl(l.dd10, 0)) dd10,
                           sum(nvl(l.dd11, 0)) dd11,sum(nvl(l.dd12, 0)) dd12,sum(nvl(l.dd13, 0)) dd13,sum(nvl(l.dd14, 0)) dd14,sum(nvl(l.dd15, 0)) dd15,
                           sum(nvl(l.dd16, 0)) dd16,sum(nvl(l.dd17, 0)) dd17,sum(nvl(l.dd18, 0)) dd18,sum(nvl(l.dd19, 0)) dd19,sum(nvl(l.dd20, 0)) dd20,
                           sum(nvl(l.dd21, 0)) dd21,sum(nvl(l.dd22, 0)) dd22,sum(nvl(l.dd23, 0)) dd23,sum(nvl(l.dd24, 0)) dd24,sum(nvl(l.dd25, 0)) dd25,
                           sum(nvl(l.dd26, 0)) dd26,sum(nvl(l.dd27, 0)) dd27,sum(nvl(l.dd28, 0)) dd28,sum(nvl(l.dd29, 0)) dd29,sum(nvl(l.dd30, 0)) dd30,
                           sum(nvl(l.dd31, 0)) dd31
                from api20_date_log l, api20_mst m
                where l.api = m.api
                  and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
                  and decode(i_grp, null, 1, instr(i_grp, m.func_name)) != 0
                  and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
                  -- and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
                  and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
                group by l.ym, m.func_name, m.func_dispnum
              ) l,
              (select ym, api, dispnum from (
                 select m.func_name api, m.func_dispnum dispnum
                 from api20_mst m
                 where decode(i_grp, null, 1, instr(i_grp, m.func_name)) != 0
                 group by m.func_name, m.func_dispnum) a,
                 (select column_value ym from table(f_ym_tbl_func(nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')), nvl(i_ym, to_char(sysdate,'yyyymm')))))) t
              where l.ym(+) = t.ym
                and l.api(+) = t.api
                and l.dispnum(+) = t.dispnum
            )
            group by api, dispnum
          ) o
        ) p
        where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
        order by rnum
    */
    /* ワーク変数 */;
    w_cnt INTEGER;
    w_msg CHARACTER VARYING(500);
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20log.p_api_log_pkg$p_get_date');
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
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_date', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', log_rec.dd_info));
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
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_date', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.sum_total, '",', 'rate', ':"', log_rec.rate, '",', log_rec.dd_info));
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
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_date', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', log_rec.dd_info));
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
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_date', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.sum_total, '",', 'rate', ':"', log_rec.rate, '",', log_rec.dd_info));
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
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_date', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', log_rec.dd_info));
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
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_date', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.sum_total, '",', 'rate', ':"', log_rec.rate, '",', log_rec.dd_info));
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
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_date', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.total, '",', 'rate', ':"', log_rec.rate, '",', log_rec.dd_info));
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
                    PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20log.p_api_log_pkg$p_get_date', CONCAT_WS('', 'api', ':"', log_rec.api, '",', 'total', ':"', log_rec.sum_total, '",', 'rate', ':"', log_rec.rate, '",', log_rec.dd_info));
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
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20log.p_api_log_pkg$p_get_date', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20log.p_api_log_pkg$p_get_date');
    EXCEPTION
        WHEN others THEN
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg := substrb(sqlerrm, 1, 500)
            */
            /* insert into error_log values(sysdate, 'P_GET_DATE', i_cid, w_msg); */
            /* commit; */
            o_rtncd := 7000;
END;
$BODY$
LANGUAGE  plpgsql;