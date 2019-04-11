CREATE OR REPLACE PACKAGE "API20LOG".p_api_log_pkg AS

-- 変数定義
TYPE tbl_type	IS TABLE OF varchar2(4000)
		INDEX BY BINARY_INTEGER;	-- 配列変数タイプ

---------------------------------------------------------------------------------------------------------------
-- API企業検索
---------------------------------------------------------------------------------------------------------------
procedure P_GET_API_CORP (
  i_cid		in	varchar2,		-- 企業ID
  i_cname	in	varchar2,		-- 企業名
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_info	out	tbl_type		-- 検索情報（企業ID,企業名）
);


---------------------------------------------------------------------------------------------------------------
-- APIグループ名検索
---------------------------------------------------------------------------------------------------------------
procedure P_GET_API_GRP (
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_info	out	tbl_type		-- 検索情報（グループ名）
);


---------------------------------------------------------------------------------------------------------------
-- 日別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_DATE (
  i_cid		in	varchar2,		-- 企業ID
  i_kbn		in	varchar2,		-- 検索区分（T:全体、S:サマリー、G:機能グループ名、F:機能名）
  i_month	in	varchar2,		-- 検索期間（1:１ヶ月、3:３ヶ月）
  i_ym		in	varchar2,		-- 検索年月（yyyymm）
  i_grp		in	varchar2,		-- 機能グループ名（検索区分がGの時必須）or 機能名（検索区分がFの時必須）
  i_ssl		in	varchar2,		-- SSL区分（1:SSL利用件数、0:非SSL利用件数、T:全利用件数）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_min_ym	out	varchar2,		-- 最小年月（yyyymm）
  o_max_ym	out	varchar2,		-- 最大年月（yyyymm）
  o_gokei	out	number,			-- 合計リクエスト数
  o_avg		out	number,			-- 平均リクエスト数
  o_info	out	tbl_type		-- 検索情報（API名, 合計, 割合, 1日～31日）
);


---------------------------------------------------------------------------------------------------------------
-- 時間帯別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_TIME (
  i_cid		in	varchar2,		-- 企業ID
  i_kbn		in	varchar2,		-- 検索区分（T:全体、S:サマリー、G:機能グループ名、F:機能名））
  i_month	in	varchar2,		-- 検索期間（1:１ヶ月、3:３ヶ月）
  i_ym		in	varchar2,		-- 検索年月（yyyymm）
  i_grp		in	varchar2,		-- 機能グループ名（検索区分がGの時必須）or 機能名（検索区分がFの時必須）
  i_ssl		in	varchar2,		-- SSL区分（1:SSL利用件数、0:非SSL利用件数、T:全利用件数）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_min_ym	out	varchar2,		-- 最小年月（yyyymm）
  o_max_ym	out	varchar2,		-- 最大年月（yyyymm）
  o_gokei	out	number,			-- 合計リクエスト数
  o_avg		out	number,			-- 平均リクエスト数
  o_info	out	tbl_type		-- 検索情報（API名, 日合計, 割合, 00時～23時）
);


---------------------------------------------------------------------------------------------------------------
-- 日指定時間帯別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_TIME_FUNC (
  i_cid		in	varchar2,		-- 企業ID
  i_kbn		in	varchar2,		-- 検索区分（T:全体、S:サマリー、G:機能グループ名、F:機能名））
  i_ymd		in	varchar2,		-- 検索年月日（yyyymmdd）
  i_func	in	varchar2,		-- 機能名 or 機能グループ名（検索区分に従う）
  i_ssl		in	varchar2,		-- SSL区分（1:SSL利用件数、0:非SSL利用件数、T:全利用件数）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_gokei	out	number,			-- 合計リクエスト数
  o_avg		out	number,			-- 平均リクエスト数
  o_info	out	tbl_type		-- 検索情報（API名, 日合計, 割合, 00時～23時）
);


---------------------------------------------------------------------------------------------------------------
-- ホスト別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_HOST (
  i_cid		in	varchar2,		-- 企業ID
  i_month	in	varchar2,		-- 検索期間（1:１ヶ月、3:３ヶ月）
  i_ym		in	varchar2,		-- 検索年月（yyyymm）
  i_order	in	number,			-- 検索順位（1～指定順位まで出力される）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_info	out	tbl_type		-- 検索情報（API名,日合計,00時～23時）
);


---------------------------------------------------------------------------------------------------------------
-- 無償版API月別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_FAPI (
  i_cid		in	varchar2,		-- 企業ID
  i_ym		in	varchar2,		-- 検索年月（yyyymm）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_info	out	tbl_type		-- 検索情報（企業ID, 合計）
);

END p_api_log_pkg;
/


CREATE OR REPLACE PACKAGE BODY "API20LOG".p_api_log_pkg AS

---------------------------------------------------------------------------------------------------------------
-- API企業検索
---------------------------------------------------------------------------------------------------------------
procedure P_GET_API_CORP (
  i_cid		in	varchar2,		-- 企業ID
  i_cname	in	varchar2,		-- 企業名
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_info	out	tbl_type		-- 検索情報（企業ID,企業名）
) is

  cursor corp_cur (i_cid	in	varchar2,
		   i_cname	in	varchar2,
		   i_pos	in	number,
		   i_cnt	in	number) is
    select * from (
      select p.*,
             row_number() over (order by cname) rnum		-- 2011.02.14  玉川  ソート順をCIDからCNAMEに変更
      from (
        select o.*,
               count(*) over () all_cnt
        from (
	  select c.cid,
	　       c.cname
	  from api20ninsyo.api20_corp_mst c
            where decode(i_cid,   null, 1, instr(c.cid,   i_cid))   != 0
              and decode(i_cname, null, 1, instr(c.cname, i_cname)) != 0
        ) o
      ) p
    )
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  -- ワーク変数
  w_cnt		pls_integer;
  w_msg		varchar2(500);

begin
  -- クリア
  o_rtncd    := 0;
  o_cnt      := 0;

  -- データ取得
  w_cnt := 0;
  for  corp_rec in corp_cur(i_cid,
			    i_cname,
                            i_pos,
                            i_cnt) loop

    w_cnt := w_cnt + 1;
    o_info(w_cnt) := 'cid'   || ':"' || corp_rec.cid   || '",' ||
                     'cname' || ':"' || corp_rec.cname || '"';
    o_cnt := corp_rec.all_cnt;
  end loop;

  o_rtncd := 0;			-- 正常終了
exception
  when others then
    w_msg := substrb(sqlerrm, 1, 500);
--    insert into error_log values(sysdate, 'P_GET_API_CORP', i_cid, w_msg);
--    commit;
    o_rtncd := 7000;
end P_GET_API_CORP;


---------------------------------------------------------------------------------------------------------------
-- APIグループ名検索
---------------------------------------------------------------------------------------------------------------
procedure P_GET_API_GRP (
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_info	out	tbl_type		-- 検索情報（グループ名）
) is

  cursor api_grp_cur (i_pos	in	number,
		      i_cnt	in	number) is
    select * from (
      select p.*,
             row_number() over (order by grp_dispnum) rnum
      from (
        select o.*,
               count(*) over () all_cnt
        from (
	  select distinct m.func_grp_name,
	　                m.grp_dispnum
	  from api20_mst m
        ) o
      ) p
    )
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  -- ワーク変数
  w_cnt		pls_integer;
  w_msg		varchar2(500);

begin
  -- クリア
  o_rtncd    := 0;
  o_cnt      := 0;

  -- データ取得
  w_cnt := 0;
  for  api_grp_rec in api_grp_cur(i_pos,
                                  i_cnt) loop

    w_cnt := w_cnt + 1;
    o_info(w_cnt) := 'grp_name' || ':"' || api_grp_rec.func_grp_name || '"';
    o_cnt := api_grp_rec.all_cnt;
  end loop;

  o_rtncd := 0;			-- 正常終了
exception
  when others then
    w_msg := substrb(sqlerrm, 1, 500);
--    insert into error_log values(sysdate, 'P_GET_API_GRP', null, w_msg);
--    commit;
    o_rtncd := 7000;
end P_GET_API_GRP;


---------------------------------------------------------------------------------------------------------------
-- 日別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_DATE (
  i_cid		in	varchar2,		-- 企業ID
  i_kbn		in	varchar2,		-- 検索区分（T:全体、S:サマリー、G:機能グループ名、F:機能名）
  i_month	in	varchar2,		-- 検索期間（1:１ヶ月、3:３ヶ月）
  i_ym		in	varchar2,		-- 検索年月（yyyymm）
  i_grp		in	varchar2,		-- 機能グループ名（検索区分がGの時必須）or 機能名（検索区分がFの時必須）
  i_ssl		in	varchar2,		-- SSL区分（1:SSL利用件数、0:非SSL利用件数、T:全利用件数）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_min_ym	out	varchar2,		-- 最小年月（yyyymm）
  o_max_ym	out	varchar2,		-- 最大年月（yyyymm）
  o_gokei	out	number,			-- 合計リクエスト数
  o_avg		out	number,			-- 平均リクエスト数
  o_info	out	tbl_type		-- 検索情報（API名, 合計, 割合, 1日～31日）
) is

  --
  -- 全体、１ヶ月検索用カーソル
  --
  cursor log_cur_t_1 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (select api, dispnum, ym, total, min_ym, max_ym, to_number(to_char(last_day(to_date(ym, 'YYYYMM')), 'dd')) sum_cnt,
                   get_dd(ym, dd01, dd02, dd03, dd04, dd05, dd06, dd07, dd08, dd09, dd10,
                              dd11, dd12, dd13, dd14, dd15, dd16, dd17, dd18, dd19, dd20,
                              dd21, dd22, dd23, dd24, dd25, dd26, dd27, dd28, dd29, dd30, dd31) dd_info
        from (
          select nvl(a.ym, i_ym) ym, b.api, b.dispnum, nvl(a.total, 0) total, nvl(a.min_ym, i_ym) min_ym, nvl(a.max_ym, i_ym) max_ym,
                 nvl(a.dd01, 0) dd01, nvl(a.dd02, 0) dd02, nvl(a.dd03, 0) dd03, nvl(a.dd04, 0) dd04, nvl(a.dd05, 0) dd05,
                 nvl(a.dd06, 0) dd06, nvl(a.dd07, 0) dd07, nvl(a.dd08, 0) dd08, nvl(a.dd09, 0) dd09, nvl(a.dd10, 0) dd10,
                 nvl(a.dd11, 0) dd11, nvl(a.dd12, 0) dd12, nvl(a.dd13, 0) dd13, nvl(a.dd14, 0) dd14, nvl(a.dd15, 0) dd15,
                 nvl(a.dd16, 0) dd16, nvl(a.dd17, 0) dd17, nvl(a.dd18, 0) dd18, nvl(a.dd19, 0) dd19, nvl(a.dd20, 0) dd20,
                 nvl(a.dd21, 0) dd21, nvl(a.dd22, 0) dd22, nvl(a.dd23, 0) dd23, nvl(a.dd24, 0) dd24, nvl(a.dd25, 0) dd25,
                 nvl(a.dd26, 0) dd26, nvl(a.dd27, 0) dd27, nvl(a.dd28, 0) dd28, nvl(a.dd29, 0) dd29, nvl(a.dd30, 0) dd30,
                 nvl(a.dd31, 0) dd31
          from
          (select l.ym, '全体' api, 1 dispnum, sum(nvl(l.total, 0)) total, min(l.ym) min_ym, max(l.ym) max_ym,
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
            and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
            -- and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
          group by l.ym) a,
          (select '全体' api,
                  1 dispnum
           from dual) b
          where a.api(+) = b.api
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 全体、３ヶ月検索用カーソル
  --
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
    order by rnum;

  --
  -- サマリー、１ヶ月検索用カーソル
  --
  cursor log_cur_s_1 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (select api, dispnum, ym, total, min_ym, max_ym, to_number(to_char(last_day(to_date(ym, 'YYYYMM')), 'dd')) sum_cnt,
                   get_dd(ym, dd01, dd02, dd03, dd04, dd05, dd06, dd07, dd08, dd09, dd10,
                              dd11, dd12, dd13, dd14, dd15, dd16, dd17, dd18, dd19, dd20,
                              dd21, dd22, dd23, dd24, dd25, dd26, dd27, dd28, dd29, dd30, dd31) dd_info
        from (
          select nvl(a.ym, i_ym) ym, b.api, b.dispnum, nvl(a.total, 0) total, nvl(a.min_ym, i_ym) min_ym, nvl(a.max_ym, i_ym) max_ym,
                 nvl(a.dd01, 0) dd01, nvl(a.dd02, 0) dd02, nvl(a.dd03, 0) dd03, nvl(a.dd04, 0) dd04, nvl(a.dd05, 0) dd05,
                 nvl(a.dd06, 0) dd06, nvl(a.dd07, 0) dd07, nvl(a.dd08, 0) dd08, nvl(a.dd09, 0) dd09, nvl(a.dd10, 0) dd10,
                 nvl(a.dd11, 0) dd11, nvl(a.dd12, 0) dd12, nvl(a.dd13, 0) dd13, nvl(a.dd14, 0) dd14, nvl(a.dd15, 0) dd15,
                 nvl(a.dd16, 0) dd16, nvl(a.dd17, 0) dd17, nvl(a.dd18, 0) dd18, nvl(a.dd19, 0) dd19, nvl(a.dd20, 0) dd20,
                 nvl(a.dd21, 0) dd21, nvl(a.dd22, 0) dd22, nvl(a.dd23, 0) dd23, nvl(a.dd24, 0) dd24, nvl(a.dd25, 0) dd25,
                 nvl(a.dd26, 0) dd26, nvl(a.dd27, 0) dd27, nvl(a.dd28, 0) dd28, nvl(a.dd29, 0) dd29, nvl(a.dd30, 0) dd30,
                 nvl(a.dd31, 0) dd31
          from
          (select l.ym, m.func_grp_name api, m.grp_dispnum dispnum, sum(nvl(l.total, 0)) total, min(l.ym) min_ym, max(l.ym) max_ym,
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
            and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
            -- and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
          group by l.ym, m.func_grp_name, m.grp_dispnum) a,
          (select distinct m.func_grp_name api,
                           m.grp_dispnum dispnum
           from api20_mst m) b
          where a.api(+) = b.api
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- サマリー、３ヶ月検索用カーソル
  --
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
    order by rnum;

  --
  -- 機能グループ名、１ヶ月検索用カーソル
  --
  cursor log_cur_g_1 (
    i_cid		in	varchar2,
    i_grp		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (select api, dispnum, ym, total, min_ym, max_ym, to_number(to_char(last_day(to_date(ym, 'YYYYMM')), 'dd')) sum_cnt,
                   get_dd(ym, dd01, dd02, dd03, dd04, dd05, dd06, dd07, dd08, dd09, dd10,
                              dd11, dd12, dd13, dd14, dd15, dd16, dd17, dd18, dd19, dd20,
                              dd21, dd22, dd23, dd24, dd25, dd26, dd27, dd28, dd29, dd30, dd31) dd_info
        from (
          select nvl(a.ym, i_ym) ym, b.api, b.dispnum, nvl(a.total, 0) total, nvl(a.min_ym, i_ym) min_ym, nvl(a.max_ym, i_ym) max_ym,
                 nvl(a.dd01, 0) dd01, nvl(a.dd02, 0) dd02, nvl(a.dd03, 0) dd03, nvl(a.dd04, 0) dd04, nvl(a.dd05, 0) dd05,
                 nvl(a.dd06, 0) dd06, nvl(a.dd07, 0) dd07, nvl(a.dd08, 0) dd08, nvl(a.dd09, 0) dd09, nvl(a.dd10, 0) dd10,
                 nvl(a.dd11, 0) dd11, nvl(a.dd12, 0) dd12, nvl(a.dd13, 0) dd13, nvl(a.dd14, 0) dd14, nvl(a.dd15, 0) dd15,
                 nvl(a.dd16, 0) dd16, nvl(a.dd17, 0) dd17, nvl(a.dd18, 0) dd18, nvl(a.dd19, 0) dd19, nvl(a.dd20, 0) dd20,
                 nvl(a.dd21, 0) dd21, nvl(a.dd22, 0) dd22, nvl(a.dd23, 0) dd23, nvl(a.dd24, 0) dd24, nvl(a.dd25, 0) dd25,
                 nvl(a.dd26, 0) dd26, nvl(a.dd27, 0) dd27, nvl(a.dd28, 0) dd28, nvl(a.dd29, 0) dd29, nvl(a.dd30, 0) dd30,
                 nvl(a.dd31, 0) dd31
          from
          (select l.ym, m.func_name api, m.func_dispnum dispnum, sum(nvl(l.total, 0)) total, min(l.ym) min_ym, max(l.ym) max_ym,
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
            and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
            -- and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
          group by l.ym, m.func_name, m.func_dispnum) a,
          (select m.func_name api,
                  m.func_dispnum dispnum
           from api20_mst m
           where m.func_grp_name = i_grp) b
          where a.api(+) = b.api
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 機能グループ名、３ヶ月検索用カーソル
  --
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
    order by rnum;

  --
  -- 機能名、１ヶ月検索用カーソル
  --
  cursor log_cur_f_1 (
    i_cid		in	varchar2,
    i_grp		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (select api, dispnum, ym, total, min_ym, max_ym, to_number(to_char(last_day(to_date(ym, 'YYYYMM')), 'dd')) sum_cnt,
                   get_dd(ym, dd01, dd02, dd03, dd04, dd05, dd06, dd07, dd08, dd09, dd10,
                              dd11, dd12, dd13, dd14, dd15, dd16, dd17, dd18, dd19, dd20,
                              dd21, dd22, dd23, dd24, dd25, dd26, dd27, dd28, dd29, dd30, dd31) dd_info
        from (
          select nvl(a.ym, i_ym) ym, b.api, b.dispnum, nvl(a.total, 0) total, nvl(a.min_ym, i_ym) min_ym, nvl(a.max_ym, i_ym) max_ym,
                 nvl(a.dd01, 0) dd01, nvl(a.dd02, 0) dd02, nvl(a.dd03, 0) dd03, nvl(a.dd04, 0) dd04, nvl(a.dd05, 0) dd05,
                 nvl(a.dd06, 0) dd06, nvl(a.dd07, 0) dd07, nvl(a.dd08, 0) dd08, nvl(a.dd09, 0) dd09, nvl(a.dd10, 0) dd10,
                 nvl(a.dd11, 0) dd11, nvl(a.dd12, 0) dd12, nvl(a.dd13, 0) dd13, nvl(a.dd14, 0) dd14, nvl(a.dd15, 0) dd15,
                 nvl(a.dd16, 0) dd16, nvl(a.dd17, 0) dd17, nvl(a.dd18, 0) dd18, nvl(a.dd19, 0) dd19, nvl(a.dd20, 0) dd20,
                 nvl(a.dd21, 0) dd21, nvl(a.dd22, 0) dd22, nvl(a.dd23, 0) dd23, nvl(a.dd24, 0) dd24, nvl(a.dd25, 0) dd25,
                 nvl(a.dd26, 0) dd26, nvl(a.dd27, 0) dd27, nvl(a.dd28, 0) dd28, nvl(a.dd29, 0) dd29, nvl(a.dd30, 0) dd30,
                 nvl(a.dd31, 0) dd31
          from
          (select l.ym, m.func_name api, m.func_dispnum dispnum, sum(nvl(l.total, 0)) total, min(l.ym) min_ym, max(l.ym) max_ym,
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
            and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
            -- and ym between nvl(to_char(add_months(to_date(i_ym,'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
          group by l.ym, m.func_name, m.func_dispnum) a,
          (select m.func_name api,
                  m.func_dispnum dispnum
           from api20_mst m
           where m.func_name = i_grp) b
          where a.api(+) = b.api
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 機能名、３ヶ月検索用カーソル
  --
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
    order by rnum;

  -- ワーク変数
  w_cnt		pls_integer;
  w_msg		varchar2(500);

begin
  -- クリア
  o_rtncd    := 0;
  o_cnt      := 0;

  case i_kbn
    when 'T' then
      if i_month = '1' then
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_t_1 (i_cid, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           log_rec.dd_info;
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      else
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_t_3 (i_cid, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api       || '",' ||
                           'total' || ':"' || log_rec.sum_total || '",' ||
                           'rate'  || ':"' || log_rec.rate      || '",' ||
                           log_rec.dd_info;
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      end if;

    when 'S' then
      if i_month = '1' then
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_s_1 (i_cid, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           log_rec.dd_info;
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      else
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_s_3 (i_cid, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api       || '",' ||
                           'total' || ':"' || log_rec.sum_total || '",' ||
                           'rate'  || ':"' || log_rec.rate      || '",' ||
                           log_rec.dd_info;
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      end if;

    when 'G' then
      if i_month = '1' then
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_g_1 (i_cid, i_grp, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           log_rec.dd_info;
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      else
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_g_3 (i_cid, i_grp, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api       || '",' ||
                           'total' || ':"' || log_rec.sum_total || '",' ||
                           'rate'  || ':"' || log_rec.rate      || '",' ||
                           log_rec.dd_info;
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      end if;

    when 'F' then
      if i_month = '1' then
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_f_1 (i_cid, i_grp, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           log_rec.dd_info;
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      else
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_f_3 (i_cid, i_grp, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api       || '",' ||
                           'total' || ':"' || log_rec.sum_total || '",' ||
                           'rate'  || ':"' || log_rec.rate      || '",' ||
                           log_rec.dd_info;
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      end if;

    else
      null;

  end case;

  o_rtncd := 0;			-- 正常終了
exception
  when others then
    w_msg := substrb(sqlerrm, 1, 500);
--    insert into error_log values(sysdate, 'P_GET_DATE', i_cid, w_msg);
--    commit;
    o_rtncd := 7000;
end P_GET_DATE;


---------------------------------------------------------------------------------------------------------------
-- 時間帯別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_TIME (
  i_cid		in	varchar2,		-- 企業ID
  i_kbn		in	varchar2,		-- 検索区分（T:全体、S:サマリー、G:機能グループ名、F:機能名））
  i_month	in	varchar2,		-- 検索期間（1:１ヶ月、3:３ヶ月）
  i_ym		in	varchar2,		-- 検索年月（yyyymm）
  i_grp		in	varchar2,		-- 機能グループ名（検索区分がGの時必須）or 機能名（検索区分がFの時必須）
  i_ssl		in	varchar2,		-- SSL区分（1:SSL利用件数、0:非SSL利用件数、T:全利用件数）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_min_ym	out	varchar2,		-- 最小年月（yyyymm）
  o_max_ym	out	varchar2,		-- 最大年月（yyyymm）
  o_gokei	out	number,			-- 合計リクエスト数
  o_avg		out	number,			-- 平均リクエスト数
  o_info	out	tbl_type		-- 検索情報（API名, 日合計, 割合, 00時～23時）
) is

  --
  -- 全体、１ヶ月検索用カーソル
  --
  cursor log_cur_t_1 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (select l.*, 24 sum_cnt
        from (
          select nvl(a.ym, i_ym) ym, b.api, b.dispnum, nvl(a.total, 0) total, nvl(a.min_ym, i_ym) min_ym, nvl(a.max_ym, i_ym) max_ym,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymm') ym, '全体' api, 1 dispnum, sum(nvl(l.total, 0)) total, min(to_char(l.ymd,'yyyymm')) min_ym, max(to_char(l.ymd,'yyyymm')) max_ym,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm'))
             -- and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
           group by to_char(l.ymd,'yyyymm')) a,
          (select '全体' api,
                  1 dispnum
           from dual) b
          where a.api(+) = b.api
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 全体、３ヶ月検索用カーソル
  --
  cursor log_cur_t_3 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (
        select api, dispnum, sum(total) total, min(ym) min_ym, max(ym) max_ym,
               sum(hh00) hh00, sum(hh01) hh01, sum(hh02) hh02, sum(hh03) hh03,
               sum(hh04) hh04, sum(hh05) hh05, sum(hh06) hh06, sum(hh07) hh07,
               sum(hh08) hh08, sum(hh09) hh09, sum(hh10) hh10, sum(hh11) hh11,
               sum(hh12) hh12, sum(hh13) hh13, sum(hh14) hh14, sum(hh15) hh15,
               sum(hh16) hh16, sum(hh17) hh17, sum(hh18) hh18, sum(hh19) hh19,
               sum(hh20) hh20, sum(hh21) hh21, sum(hh22) hh22, sum(hh23) hh23,
               24 sum_cnt
          from (
          select b.ym, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymm') ym, '全体' api, 1 dispnum, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             -- and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm'))
             and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
           group by to_char(l.ymd,'yyyymm')) a,
          (select ym, '全体' api,
                      1 dispnum
           from dual,
           (select column_value ym from table(f_ym_tbl_func(nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')), nvl(i_ym, to_char(sysdate,'yyyymm')))))
          ) b
          where a.api(+) = b.api
            and a.ym(+)  = b.ym
        )
        group by api, dispnum
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- サマリー、１ヶ月検索用カーソル
  --
  cursor log_cur_s_1 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (
        select api, dispnum, sum(total) total, min(ym) min_ym, max(ym) max_ym,
               sum(hh00) hh00, sum(hh01) hh01, sum(hh02) hh02, sum(hh03) hh03,
               sum(hh04) hh04, sum(hh05) hh05, sum(hh06) hh06, sum(hh07) hh07,
               sum(hh08) hh08, sum(hh09) hh09, sum(hh10) hh10, sum(hh11) hh11,
               sum(hh12) hh12, sum(hh13) hh13, sum(hh14) hh14, sum(hh15) hh15,
               sum(hh16) hh16, sum(hh17) hh17, sum(hh18) hh18, sum(hh19) hh19,
               sum(hh20) hh20, sum(hh21) hh21, sum(hh22) hh22, sum(hh23) hh23,
               24 sum_cnt
          from (
          select b.ym, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymm') ym, m.func_grp_name api, m.grp_dispnum dispnum, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm'))
             -- and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
           group by to_char(l.ymd,'yyyymm'), m.func_grp_name, m.grp_dispnum) a,
          (select distinct i_ym ym, m.func_grp_name api,
                           m.grp_dispnum dispnum
           from api20_mst m
          ) b
          where a.api(+) = b.api
            and a.ym(+)  = b.ym
        )
        group by api, dispnum
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- サマリー、３ヶ月検索用カーソル
  --
  cursor log_cur_s_3 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (
        select api, dispnum, sum(total) total, min(ym) min_ym, max(ym) max_ym,
               sum(hh00) hh00, sum(hh01) hh01, sum(hh02) hh02, sum(hh03) hh03,
               sum(hh04) hh04, sum(hh05) hh05, sum(hh06) hh06, sum(hh07) hh07,
               sum(hh08) hh08, sum(hh09) hh09, sum(hh10) hh10, sum(hh11) hh11,
               sum(hh12) hh12, sum(hh13) hh13, sum(hh14) hh14, sum(hh15) hh15,
               sum(hh16) hh16, sum(hh17) hh17, sum(hh18) hh18, sum(hh19) hh19,
               sum(hh20) hh20, sum(hh21) hh21, sum(hh22) hh22, sum(hh23) hh23,
               24 sum_cnt
          from (
          select b.ym, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymm') ym, m.func_grp_name api, m.grp_dispnum dispnum, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             -- and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm'))
             and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
           group by to_char(l.ymd,'yyyymm'), m.func_grp_name, m.grp_dispnum) a,
          (select distinct ym, m.func_grp_name api,
                           m.grp_dispnum dispnum
           from api20_mst m,
           (select column_value ym from table(f_ym_tbl_func(nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')), nvl(i_ym, to_char(sysdate,'yyyymm')))))
          ) b
          where a.api(+) = b.api
            and a.ym(+)  = b.ym
        )
        group by api, dispnum
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 機能グループ名、１ヶ月検索用カーソル
  --
  cursor log_cur_g_1 (
    i_cid		in	varchar2,
    i_grp		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (
        select api, dispnum, sum(total) total, min(ym) min_ym, max(ym) max_ym,
               sum(hh00) hh00, sum(hh01) hh01, sum(hh02) hh02, sum(hh03) hh03,
               sum(hh04) hh04, sum(hh05) hh05, sum(hh06) hh06, sum(hh07) hh07,
               sum(hh08) hh08, sum(hh09) hh09, sum(hh10) hh10, sum(hh11) hh11,
               sum(hh12) hh12, sum(hh13) hh13, sum(hh14) hh14, sum(hh15) hh15,
               sum(hh16) hh16, sum(hh17) hh17, sum(hh18) hh18, sum(hh19) hh19,
               sum(hh20) hh20, sum(hh21) hh21, sum(hh22) hh22, sum(hh23) hh23,
               24 sum_cnt
          from (
          select b.ym, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymm') ym, m.func_name api, m.func_dispnum dispnum, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
             and decode(i_grp, null, 1, instr(i_grp, m.func_grp_name)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm'))
             -- and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
           group by to_char(l.ymd,'yyyymm'), m.func_name, m.func_dispnum) a,
          (select distinct i_ym ym, m.func_name api,
                           m.func_dispnum dispnum
           from api20_mst m
           where m.func_grp_name = i_grp
          ) b
          where a.api(+) = b.api
            and a.ym(+)  = b.ym
        )
        group by api, dispnum
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 機能グループ名、３ヶ月検索用カーソル
  --
  cursor log_cur_g_3 (
    i_cid		in	varchar2,
    i_grp		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (
        select api, dispnum, sum(total) total, min(ym) min_ym, max(ym) max_ym,
               sum(hh00) hh00, sum(hh01) hh01, sum(hh02) hh02, sum(hh03) hh03,
               sum(hh04) hh04, sum(hh05) hh05, sum(hh06) hh06, sum(hh07) hh07,
               sum(hh08) hh08, sum(hh09) hh09, sum(hh10) hh10, sum(hh11) hh11,
               sum(hh12) hh12, sum(hh13) hh13, sum(hh14) hh14, sum(hh15) hh15,
               sum(hh16) hh16, sum(hh17) hh17, sum(hh18) hh18, sum(hh19) hh19,
               sum(hh20) hh20, sum(hh21) hh21, sum(hh22) hh22, sum(hh23) hh23,
               24 sum_cnt
          from (
          select b.ym, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymm') ym, m.func_name api, m.func_dispnum dispnum, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
             and decode(i_grp, null, 1, instr(i_grp, m.func_grp_name)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             -- and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm'))
             and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
           group by to_char(l.ymd,'yyyymm'), m.func_name, m.func_dispnum) a,
          (select distinct ym, m.func_name api,
                           m.func_dispnum dispnum
           from api20_mst m,
           (select column_value ym from table(f_ym_tbl_func(nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')), nvl(i_ym, to_char(sysdate,'yyyymm')))))
           where m.func_grp_name = i_grp
          ) b
          where a.api(+) = b.api
            and a.ym(+)  = b.ym
        )
        group by api, dispnum
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 機能名、１ヶ月検索用カーソル
  --
  cursor log_cur_f_1 (
    i_cid		in	varchar2,
    i_grp		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (
        select api, dispnum, sum(total) total, min(ym) min_ym, max(ym) max_ym,
               sum(hh00) hh00, sum(hh01) hh01, sum(hh02) hh02, sum(hh03) hh03,
               sum(hh04) hh04, sum(hh05) hh05, sum(hh06) hh06, sum(hh07) hh07,
               sum(hh08) hh08, sum(hh09) hh09, sum(hh10) hh10, sum(hh11) hh11,
               sum(hh12) hh12, sum(hh13) hh13, sum(hh14) hh14, sum(hh15) hh15,
               sum(hh16) hh16, sum(hh17) hh17, sum(hh18) hh18, sum(hh19) hh19,
               sum(hh20) hh20, sum(hh21) hh21, sum(hh22) hh22, sum(hh23) hh23,
               24 sum_cnt
          from (
          select b.ym, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymm') ym, m.func_name api, m.func_dispnum dispnum, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
             and decode(i_grp, null, 1, instr(i_grp, m.func_name)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm'))
             -- and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
           group by to_char(l.ymd,'yyyymm'), m.func_name, m.func_dispnum) a,
          (select distinct i_ym ym, m.func_name api,
                           m.func_dispnum dispnum
           from api20_mst m
           where m.func_name = i_grp
          ) b
          where a.api(+) = b.api
            and a.ym(+)  = b.ym
        )
        group by api, dispnum
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 機能名、３ヶ月検索用カーソル
  --
  cursor log_cur_f_3 (
    i_cid		in	varchar2,
    i_grp		in	varchar2,
    i_ym		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (
        select api, dispnum, sum(total) total, min(ym) min_ym, max(ym) max_ym,
               sum(hh00) hh00, sum(hh01) hh01, sum(hh02) hh02, sum(hh03) hh03,
               sum(hh04) hh04, sum(hh05) hh05, sum(hh06) hh06, sum(hh07) hh07,
               sum(hh08) hh08, sum(hh09) hh09, sum(hh10) hh10, sum(hh11) hh11,
               sum(hh12) hh12, sum(hh13) hh13, sum(hh14) hh14, sum(hh15) hh15,
               sum(hh16) hh16, sum(hh17) hh17, sum(hh18) hh18, sum(hh19) hh19,
               sum(hh20) hh20, sum(hh21) hh21, sum(hh22) hh22, sum(hh23) hh23,
               24 sum_cnt
          from (
          select b.ym, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymm') ym, m.func_name api, m.func_dispnum dispnum, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
             and decode(i_grp, null, 1, instr(i_grp, m.func_name)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             -- and to_char(l.ymd,'yyyymm') = nvl(i_ym, to_char(sysdate,'yyyymm'))
             and to_char(l.ymd,'yyyymm') between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
           group by to_char(l.ymd,'yyyymm'), m.func_name, m.func_dispnum) a,
          (select distinct ym, m.func_name api,
                           m.func_dispnum dispnum
           from api20_mst m,
           (select column_value ym from table(f_ym_tbl_func(nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')), nvl(i_ym, to_char(sysdate,'yyyymm')))))
           where m.func_name = i_grp
          ) b
          where a.api(+) = b.api
            and a.ym(+)  = b.ym
        )
        group by api, dispnum
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  -- ワーク変数
  w_cnt		pls_integer;
  w_msg		varchar2(500);

begin
  -- クリア
  o_rtncd    := 0;
  o_cnt      := 0;

  case i_kbn
    when 'T' then
      if i_month = '1' then
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_t_1 (i_cid, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           'hh00'  || ':"' || log_rec.hh00  || '",' ||
                           'hh01'  || ':"' || log_rec.hh01  || '",' ||
                           'hh02'  || ':"' || log_rec.hh02  || '",' ||
                           'hh03'  || ':"' || log_rec.hh03  || '",' ||
                           'hh04'  || ':"' || log_rec.hh04  || '",' ||
                           'hh05'  || ':"' || log_rec.hh05  || '",' ||
                           'hh06'  || ':"' || log_rec.hh06  || '",' ||
                           'hh07'  || ':"' || log_rec.hh07  || '",' ||
                           'hh08'  || ':"' || log_rec.hh08  || '",' ||
                           'hh09'  || ':"' || log_rec.hh09  || '",' ||
                           'hh10'  || ':"' || log_rec.hh10  || '",' ||
                           'hh11'  || ':"' || log_rec.hh11  || '",' ||
                           'hh12'  || ':"' || log_rec.hh12  || '",' ||
                           'hh13'  || ':"' || log_rec.hh13  || '",' ||
                           'hh14'  || ':"' || log_rec.hh14  || '",' ||
                           'hh15'  || ':"' || log_rec.hh15  || '",' ||
                           'hh16'  || ':"' || log_rec.hh16  || '",' ||
                           'hh17'  || ':"' || log_rec.hh17  || '",' ||
                           'hh18'  || ':"' || log_rec.hh18  || '",' ||
                           'hh19'  || ':"' || log_rec.hh19  || '",' ||
                           'hh20'  || ':"' || log_rec.hh20  || '",' ||
                           'hh21'  || ':"' || log_rec.hh21  || '",' ||
                           'hh22'  || ':"' || log_rec.hh22  || '",' ||
                           'hh23'  || ':"' || log_rec.hh23  || '"';
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      else
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_t_3 (i_cid, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           'hh00'  || ':"' || log_rec.hh00  || '",' ||
                           'hh01'  || ':"' || log_rec.hh01  || '",' ||
                           'hh02'  || ':"' || log_rec.hh02  || '",' ||
                           'hh03'  || ':"' || log_rec.hh03  || '",' ||
                           'hh04'  || ':"' || log_rec.hh04  || '",' ||
                           'hh05'  || ':"' || log_rec.hh05  || '",' ||
                           'hh06'  || ':"' || log_rec.hh06  || '",' ||
                           'hh07'  || ':"' || log_rec.hh07  || '",' ||
                           'hh08'  || ':"' || log_rec.hh08  || '",' ||
                           'hh09'  || ':"' || log_rec.hh09  || '",' ||
                           'hh10'  || ':"' || log_rec.hh10  || '",' ||
                           'hh11'  || ':"' || log_rec.hh11  || '",' ||
                           'hh12'  || ':"' || log_rec.hh12  || '",' ||
                           'hh13'  || ':"' || log_rec.hh13  || '",' ||
                           'hh14'  || ':"' || log_rec.hh14  || '",' ||
                           'hh15'  || ':"' || log_rec.hh15  || '",' ||
                           'hh16'  || ':"' || log_rec.hh16  || '",' ||
                           'hh17'  || ':"' || log_rec.hh17  || '",' ||
                           'hh18'  || ':"' || log_rec.hh18  || '",' ||
                           'hh19'  || ':"' || log_rec.hh19  || '",' ||
                           'hh20'  || ':"' || log_rec.hh20  || '",' ||
                           'hh21'  || ':"' || log_rec.hh21  || '",' ||
                           'hh22'  || ':"' || log_rec.hh22  || '",' ||
                           'hh23'  || ':"' || log_rec.hh23  || '"';
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      end if;

    when 'S' then
      if i_month = '1' then
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_s_1 (i_cid, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           'hh00'  || ':"' || log_rec.hh00  || '",' ||
                           'hh01'  || ':"' || log_rec.hh01  || '",' ||
                           'hh02'  || ':"' || log_rec.hh02  || '",' ||
                           'hh03'  || ':"' || log_rec.hh03  || '",' ||
                           'hh04'  || ':"' || log_rec.hh04  || '",' ||
                           'hh05'  || ':"' || log_rec.hh05  || '",' ||
                           'hh06'  || ':"' || log_rec.hh06  || '",' ||
                           'hh07'  || ':"' || log_rec.hh07  || '",' ||
                           'hh08'  || ':"' || log_rec.hh08  || '",' ||
                           'hh09'  || ':"' || log_rec.hh09  || '",' ||
                           'hh10'  || ':"' || log_rec.hh10  || '",' ||
                           'hh11'  || ':"' || log_rec.hh11  || '",' ||
                           'hh12'  || ':"' || log_rec.hh12  || '",' ||
                           'hh13'  || ':"' || log_rec.hh13  || '",' ||
                           'hh14'  || ':"' || log_rec.hh14  || '",' ||
                           'hh15'  || ':"' || log_rec.hh15  || '",' ||
                           'hh16'  || ':"' || log_rec.hh16  || '",' ||
                           'hh17'  || ':"' || log_rec.hh17  || '",' ||
                           'hh18'  || ':"' || log_rec.hh18  || '",' ||
                           'hh19'  || ':"' || log_rec.hh19  || '",' ||
                           'hh20'  || ':"' || log_rec.hh20  || '",' ||
                           'hh21'  || ':"' || log_rec.hh21  || '",' ||
                           'hh22'  || ':"' || log_rec.hh22  || '",' ||
                           'hh23'  || ':"' || log_rec.hh23  || '"';
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      else
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_s_3 (i_cid, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           'hh00'  || ':"' || log_rec.hh00  || '",' ||
                           'hh01'  || ':"' || log_rec.hh01  || '",' ||
                           'hh02'  || ':"' || log_rec.hh02  || '",' ||
                           'hh03'  || ':"' || log_rec.hh03  || '",' ||
                           'hh04'  || ':"' || log_rec.hh04  || '",' ||
                           'hh05'  || ':"' || log_rec.hh05  || '",' ||
                           'hh06'  || ':"' || log_rec.hh06  || '",' ||
                           'hh07'  || ':"' || log_rec.hh07  || '",' ||
                           'hh08'  || ':"' || log_rec.hh08  || '",' ||
                           'hh09'  || ':"' || log_rec.hh09  || '",' ||
                           'hh10'  || ':"' || log_rec.hh10  || '",' ||
                           'hh11'  || ':"' || log_rec.hh11  || '",' ||
                           'hh12'  || ':"' || log_rec.hh12  || '",' ||
                           'hh13'  || ':"' || log_rec.hh13  || '",' ||
                           'hh14'  || ':"' || log_rec.hh14  || '",' ||
                           'hh15'  || ':"' || log_rec.hh15  || '",' ||
                           'hh16'  || ':"' || log_rec.hh16  || '",' ||
                           'hh17'  || ':"' || log_rec.hh17  || '",' ||
                           'hh18'  || ':"' || log_rec.hh18  || '",' ||
                           'hh19'  || ':"' || log_rec.hh19  || '",' ||
                           'hh20'  || ':"' || log_rec.hh20  || '",' ||
                           'hh21'  || ':"' || log_rec.hh21  || '",' ||
                           'hh22'  || ':"' || log_rec.hh22  || '",' ||
                           'hh23'  || ':"' || log_rec.hh23  || '"';
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      end if;

    when 'G' then
      if i_month = '1' then
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_g_1 (i_cid, i_grp, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           'hh00'  || ':"' || log_rec.hh00  || '",' ||
                           'hh01'  || ':"' || log_rec.hh01  || '",' ||
                           'hh02'  || ':"' || log_rec.hh02  || '",' ||
                           'hh03'  || ':"' || log_rec.hh03  || '",' ||
                           'hh04'  || ':"' || log_rec.hh04  || '",' ||
                           'hh05'  || ':"' || log_rec.hh05  || '",' ||
                           'hh06'  || ':"' || log_rec.hh06  || '",' ||
                           'hh07'  || ':"' || log_rec.hh07  || '",' ||
                           'hh08'  || ':"' || log_rec.hh08  || '",' ||
                           'hh09'  || ':"' || log_rec.hh09  || '",' ||
                           'hh10'  || ':"' || log_rec.hh10  || '",' ||
                           'hh11'  || ':"' || log_rec.hh11  || '",' ||
                           'hh12'  || ':"' || log_rec.hh12  || '",' ||
                           'hh13'  || ':"' || log_rec.hh13  || '",' ||
                           'hh14'  || ':"' || log_rec.hh14  || '",' ||
                           'hh15'  || ':"' || log_rec.hh15  || '",' ||
                           'hh16'  || ':"' || log_rec.hh16  || '",' ||
                           'hh17'  || ':"' || log_rec.hh17  || '",' ||
                           'hh18'  || ':"' || log_rec.hh18  || '",' ||
                           'hh19'  || ':"' || log_rec.hh19  || '",' ||
                           'hh20'  || ':"' || log_rec.hh20  || '",' ||
                           'hh21'  || ':"' || log_rec.hh21  || '",' ||
                           'hh22'  || ':"' || log_rec.hh22  || '",' ||
                           'hh23'  || ':"' || log_rec.hh23  || '"';
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      else
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_g_3 (i_cid, i_grp, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           'hh00'  || ':"' || log_rec.hh00  || '",' ||
                           'hh01'  || ':"' || log_rec.hh01  || '",' ||
                           'hh02'  || ':"' || log_rec.hh02  || '",' ||
                           'hh03'  || ':"' || log_rec.hh03  || '",' ||
                           'hh04'  || ':"' || log_rec.hh04  || '",' ||
                           'hh05'  || ':"' || log_rec.hh05  || '",' ||
                           'hh06'  || ':"' || log_rec.hh06  || '",' ||
                           'hh07'  || ':"' || log_rec.hh07  || '",' ||
                           'hh08'  || ':"' || log_rec.hh08  || '",' ||
                           'hh09'  || ':"' || log_rec.hh09  || '",' ||
                           'hh10'  || ':"' || log_rec.hh10  || '",' ||
                           'hh11'  || ':"' || log_rec.hh11  || '",' ||
                           'hh12'  || ':"' || log_rec.hh12  || '",' ||
                           'hh13'  || ':"' || log_rec.hh13  || '",' ||
                           'hh14'  || ':"' || log_rec.hh14  || '",' ||
                           'hh15'  || ':"' || log_rec.hh15  || '",' ||
                           'hh16'  || ':"' || log_rec.hh16  || '",' ||
                           'hh17'  || ':"' || log_rec.hh17  || '",' ||
                           'hh18'  || ':"' || log_rec.hh18  || '",' ||
                           'hh19'  || ':"' || log_rec.hh19  || '",' ||
                           'hh20'  || ':"' || log_rec.hh20  || '",' ||
                           'hh21'  || ':"' || log_rec.hh21  || '",' ||
                           'hh22'  || ':"' || log_rec.hh22  || '",' ||
                           'hh23'  || ':"' || log_rec.hh23  || '"';
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      end if;

    when 'F' then
      if i_month = '1' then
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_f_1 (i_cid, i_grp, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           'hh00'  || ':"' || log_rec.hh00  || '",' ||
                           'hh01'  || ':"' || log_rec.hh01  || '",' ||
                           'hh02'  || ':"' || log_rec.hh02  || '",' ||
                           'hh03'  || ':"' || log_rec.hh03  || '",' ||
                           'hh04'  || ':"' || log_rec.hh04  || '",' ||
                           'hh05'  || ':"' || log_rec.hh05  || '",' ||
                           'hh06'  || ':"' || log_rec.hh06  || '",' ||
                           'hh07'  || ':"' || log_rec.hh07  || '",' ||
                           'hh08'  || ':"' || log_rec.hh08  || '",' ||
                           'hh09'  || ':"' || log_rec.hh09  || '",' ||
                           'hh10'  || ':"' || log_rec.hh10  || '",' ||
                           'hh11'  || ':"' || log_rec.hh11  || '",' ||
                           'hh12'  || ':"' || log_rec.hh12  || '",' ||
                           'hh13'  || ':"' || log_rec.hh13  || '",' ||
                           'hh14'  || ':"' || log_rec.hh14  || '",' ||
                           'hh15'  || ':"' || log_rec.hh15  || '",' ||
                           'hh16'  || ':"' || log_rec.hh16  || '",' ||
                           'hh17'  || ':"' || log_rec.hh17  || '",' ||
                           'hh18'  || ':"' || log_rec.hh18  || '",' ||
                           'hh19'  || ':"' || log_rec.hh19  || '",' ||
                           'hh20'  || ':"' || log_rec.hh20  || '",' ||
                           'hh21'  || ':"' || log_rec.hh21  || '",' ||
                           'hh22'  || ':"' || log_rec.hh22  || '",' ||
                           'hh23'  || ':"' || log_rec.hh23  || '"';
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      else
        -- データ取得
        w_cnt := 0;
        for  log_rec in log_cur_f_3 (i_cid, i_grp, chg_ym(i_ym), i_ssl, i_pos, i_cnt) loop
          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                           'total' || ':"' || log_rec.total || '",' ||
                           'rate'  || ':"' || log_rec.rate  || '",' ||
                           'hh00'  || ':"' || log_rec.hh00  || '",' ||
                           'hh01'  || ':"' || log_rec.hh01  || '",' ||
                           'hh02'  || ':"' || log_rec.hh02  || '",' ||
                           'hh03'  || ':"' || log_rec.hh03  || '",' ||
                           'hh04'  || ':"' || log_rec.hh04  || '",' ||
                           'hh05'  || ':"' || log_rec.hh05  || '",' ||
                           'hh06'  || ':"' || log_rec.hh06  || '",' ||
                           'hh07'  || ':"' || log_rec.hh07  || '",' ||
                           'hh08'  || ':"' || log_rec.hh08  || '",' ||
                           'hh09'  || ':"' || log_rec.hh09  || '",' ||
                           'hh10'  || ':"' || log_rec.hh10  || '",' ||
                           'hh11'  || ':"' || log_rec.hh11  || '",' ||
                           'hh12'  || ':"' || log_rec.hh12  || '",' ||
                           'hh13'  || ':"' || log_rec.hh13  || '",' ||
                           'hh14'  || ':"' || log_rec.hh14  || '",' ||
                           'hh15'  || ':"' || log_rec.hh15  || '",' ||
                           'hh16'  || ':"' || log_rec.hh16  || '",' ||
                           'hh17'  || ':"' || log_rec.hh17  || '",' ||
                           'hh18'  || ':"' || log_rec.hh18  || '",' ||
                           'hh19'  || ':"' || log_rec.hh19  || '",' ||
                           'hh20'  || ':"' || log_rec.hh20  || '",' ||
                           'hh21'  || ':"' || log_rec.hh21  || '",' ||
                           'hh22'  || ':"' || log_rec.hh22  || '",' ||
                           'hh23'  || ':"' || log_rec.hh23  || '"';
          o_cnt    := log_rec.all_cnt;
          o_min_ym := log_rec.min_ym;
          o_max_ym := log_rec.max_ym;
          o_gokei  := log_rec.gokei;
          o_avg    := log_rec.avg_cnt;
        end loop;
      end if;

    else
      null;

  end case;

  o_rtncd := 0;			-- 正常終了
exception
  when others then
    w_msg := substrb(sqlerrm, 1, 500);
--    insert into error_log values(sysdate, 'P_GET_TIME', i_cid, w_msg);
--    commit;
    o_rtncd := 7000;
end P_GET_TIME;


---------------------------------------------------------------------------------------------------------------
-- 日指定時間帯別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_TIME_FUNC (
  i_cid		in	varchar2,		-- 企業ID
  i_kbn		in	varchar2,		-- 検索区分（T:全体、S:サマリー、G:機能グループ名、F:機能名））
  i_ymd		in	varchar2,		-- 検索年月日（yyyymmdd）
  i_func	in	varchar2,		-- 機能名 or 機能グループ名（検索区分に従う）
  i_ssl		in	varchar2,		-- SSL区分（1:SSL利用件数、0:非SSL利用件数、T:全利用件数）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_gokei	out	number,			-- 合計リクエスト数
  o_avg		out	number,			-- 平均リクエスト数
  o_info	out	tbl_type		-- 検索情報（API名, 日合計, 割合, 00時～23時）
) is

  --
  -- 機能名指定カーソル
  --
  cursor log_cur_f (
    i_cid		in	varchar2,
    i_func		in	varchar2,
    i_ymd		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by api) rnum
      from (select l.*, 24 sum_cnt
        from (
          select b.ymd, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymmdd') ymd, m.func_name api, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid,  null, 1, instr(i_cid,  l.cid)) != 0
             and decode(i_func, null, 1, instr(i_func, m.func_name)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             and to_char(l.ymd,'yyyymmdd') = nvl(i_ymd, to_char(sysdate,'yyyymmdd'))
           group by to_char(l.ymd,'yyyymmdd'), m.func_name) a,
          (select distinct i_ymd ymd, m.func_name api,
                           m.func_dispnum dispnum
           from api20_mst m
           where m.func_name = i_func
          ) b
          where a.api(+) = b.api
            and a.ymd(+)  = b.ymd
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 機能グループ名指定カーソル
  --
  cursor log_cur_g (
    i_cid		in	varchar2,
    i_func		in	varchar2,
    i_ymd		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by api) rnum
      from (select l.*, 24 sum_cnt
        from (
          select b.ymd, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymmdd') ymd, m.func_name api, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid,  null, 1, instr(i_cid,  l.cid)) != 0
             and decode(i_func, null, 1, instr(i_func, m.func_grp_name)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
            and to_char(l.ymd,'yyyymmdd') = nvl(i_ymd, to_char(sysdate,'yyyymmdd'))
           group by to_char(l.ymd,'yyyymmdd'), m.func_name) a,
          (select distinct i_ymd ymd, m.func_name api,
                           m.func_dispnum dispnum
           from api20_mst m
           where m.func_grp_name = i_func
          ) b
          where a.api(+) = b.api
            and a.ymd(+)  = b.ymd
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- サマリー指定カーソル
  --
  cursor log_cur_s (
    i_cid		in	varchar2,
    i_ymd		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (select l.*, 24 sum_cnt
        from (
          select b.ymd, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymmdd') ymd, m.func_grp_name api, m.grp_dispnum dispnum, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid,  null, 1, instr(i_cid,  l.cid)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             and to_char(l.ymd,'yyyymmdd') = nvl(i_ymd, to_char(sysdate,'yyyymmdd'))
           group by to_char(l.ymd,'yyyymmdd'), m.func_grp_name, m.grp_dispnum) a,
          (select distinct i_ymd ymd, m.func_grp_name api,
                           m.grp_dispnum dispnum
           from api20_mst m
          ) b
          where a.api(+) = b.api
            and a.ymd(+)  = b.ymd
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- 全体指定カーソル
  --
  cursor log_cur_t (
    i_cid		in	varchar2,
    i_ymd		in	varchar2,
    i_ssl		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*,
           round(total / decode(gokei, 0, 1, gokei) * 100, 1) rate,
           round(gokei / decode(sum_cnt, 0, 1, sum_cnt), 0) avg_cnt from (
      select o.*,
             sum(total) over() gokei,
             count(*) over () all_cnt,
             row_number() over (order by api) rnum
      from (select l.*, 24 sum_cnt
        from (
          select b.ymd, b.api, b.dispnum, nvl(a.total, 0) total,
                 nvl(a.hh00, 0) hh00, nvl(a.hh01, 0) hh01, nvl(a.hh02, 0) hh02, nvl(a.hh03, 0) hh03,
                 nvl(a.hh04, 0) hh04, nvl(a.hh05, 0) hh05, nvl(a.hh06, 0) hh06, nvl(a.hh07, 0) hh07,
                 nvl(a.hh08, 0) hh08, nvl(a.hh09, 0) hh09, nvl(a.hh10, 0) hh10, nvl(a.hh11, 0) hh11,
                 nvl(a.hh12, 0) hh12, nvl(a.hh13, 0) hh13, nvl(a.hh14, 0) hh14, nvl(a.hh15, 0) hh15,
                 nvl(a.hh16, 0) hh16, nvl(a.hh17, 0) hh17, nvl(a.hh18, 0) hh18, nvl(a.hh19, 0) hh19,
                 nvl(a.hh20, 0) hh20, nvl(a.hh21, 0) hh21, nvl(a.hh22, 0) hh22, nvl(a.hh23, 0) hh23
          from
          (select to_char(l.ymd,'yyyymmdd') ymd, '全体' api, sum(nvl(l.total, 0)) total,
                     sum(nvl(l.hh00, 0)) hh00,sum(nvl(l.hh01, 0)) hh01,sum(nvl(l.hh02, 0)) hh02,sum(nvl(l.hh03, 0)) hh03,
                     sum(nvl(l.hh04, 0)) hh04,sum(nvl(l.hh05, 0)) hh05,sum(nvl(l.hh06, 0)) hh06,sum(nvl(l.hh07, 0)) hh07,
                     sum(nvl(l.hh08, 0)) hh08,sum(nvl(l.hh09, 0)) hh09,sum(nvl(l.hh10, 0)) hh10,sum(nvl(l.hh11, 0)) hh11,
                     sum(nvl(l.hh12, 0)) hh12,sum(nvl(l.hh13, 0)) hh13,sum(nvl(l.hh14, 0)) hh14,sum(nvl(l.hh15, 0)) hh15,
                     sum(nvl(l.hh16, 0)) hh16,sum(nvl(l.hh17, 0)) hh17,sum(nvl(l.hh18, 0)) hh18,sum(nvl(l.hh19, 0)) hh19,
                     sum(nvl(l.hh20, 0)) hh20,sum(nvl(l.hh21, 0)) hh21,sum(nvl(l.hh22, 0)) hh22,sum(nvl(l.hh23, 0)) hh23
           from api20_time_log l, api20_mst m
           where l.api = m.api
             and decode(i_cid,  null, 1, instr(i_cid,  l.cid)) != 0
             and decode(i_ssl, 'T', 1, instr(i_ssl, l.ssl)) != 0
             and to_char(l.ymd,'yyyymmdd') = nvl(i_ymd, to_char(sysdate,'yyyymmdd'))
           group by to_char(l.ymd,'yyyymmdd')) a,
          (select distinct i_ymd ymd, '全体' api,
                           1 dispnum
           from dual
          ) b
          where a.api(+) = b.api
            and a.ymd(+)  = b.ymd
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;


  -- ワーク変数
  w_cnt		pls_integer;
  w_msg		varchar2(500);

begin
  -- クリア
  o_rtncd    := 0;
  o_cnt      := 0;

  case i_kbn
    when 'F' then
      -- データ取得
      w_cnt := 0;
      for  log_rec in log_cur_f(i_cid, i_func, i_ymd, i_ssl, i_pos, i_cnt) loop

        w_cnt := w_cnt + 1;
        o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                         'total' || ':"' || log_rec.total || '",' ||
                         'rate'  || ':"' || log_rec.rate  || '",' ||
                         'hh00'  || ':"' || log_rec.hh00  || '",' ||
                         'hh01'  || ':"' || log_rec.hh01  || '",' ||
                         'hh02'  || ':"' || log_rec.hh02  || '",' ||
                         'hh03'  || ':"' || log_rec.hh03  || '",' ||
                         'hh04'  || ':"' || log_rec.hh04  || '",' ||
                         'hh05'  || ':"' || log_rec.hh05  || '",' ||
                         'hh06'  || ':"' || log_rec.hh06  || '",' ||
                         'hh07'  || ':"' || log_rec.hh07  || '",' ||
                         'hh08'  || ':"' || log_rec.hh08  || '",' ||
                         'hh09'  || ':"' || log_rec.hh09  || '",' ||
                         'hh10'  || ':"' || log_rec.hh10  || '",' ||
                         'hh11'  || ':"' || log_rec.hh11  || '",' ||
                         'hh12'  || ':"' || log_rec.hh12  || '",' ||
                         'hh13'  || ':"' || log_rec.hh13  || '",' ||
                         'hh14'  || ':"' || log_rec.hh14  || '",' ||
                         'hh15'  || ':"' || log_rec.hh15  || '",' ||
                         'hh16'  || ':"' || log_rec.hh16  || '",' ||
                         'hh17'  || ':"' || log_rec.hh17  || '",' ||
                         'hh18'  || ':"' || log_rec.hh18  || '",' ||
                         'hh19'  || ':"' || log_rec.hh19  || '",' ||
                         'hh20'  || ':"' || log_rec.hh20  || '",' ||
                         'hh21'  || ':"' || log_rec.hh21  || '",' ||
                         'hh22'  || ':"' || log_rec.hh22  || '",' ||
                         'hh23'  || ':"' || log_rec.hh23  || '"';
        o_cnt    := log_rec.all_cnt;
        o_gokei  := log_rec.gokei;
        o_avg    := log_rec.avg_cnt;
      end loop;

    when 'G' then
      -- データ取得
      w_cnt := 0;
      for  log_rec in log_cur_g(i_cid, i_func, i_ymd, i_ssl, i_pos, i_cnt) loop

        w_cnt := w_cnt + 1;
        o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                         'total' || ':"' || log_rec.total || '",' ||
                         'rate'  || ':"' || log_rec.rate  || '",' ||
                         'hh00'  || ':"' || log_rec.hh00  || '",' ||
                         'hh01'  || ':"' || log_rec.hh01  || '",' ||
                         'hh02'  || ':"' || log_rec.hh02  || '",' ||
                         'hh03'  || ':"' || log_rec.hh03  || '",' ||
                         'hh04'  || ':"' || log_rec.hh04  || '",' ||
                         'hh05'  || ':"' || log_rec.hh05  || '",' ||
                         'hh06'  || ':"' || log_rec.hh06  || '",' ||
                         'hh07'  || ':"' || log_rec.hh07  || '",' ||
                         'hh08'  || ':"' || log_rec.hh08  || '",' ||
                         'hh09'  || ':"' || log_rec.hh09  || '",' ||
                         'hh10'  || ':"' || log_rec.hh10  || '",' ||
                         'hh11'  || ':"' || log_rec.hh11  || '",' ||
                         'hh12'  || ':"' || log_rec.hh12  || '",' ||
                         'hh13'  || ':"' || log_rec.hh13  || '",' ||
                         'hh14'  || ':"' || log_rec.hh14  || '",' ||
                         'hh15'  || ':"' || log_rec.hh15  || '",' ||
                         'hh16'  || ':"' || log_rec.hh16  || '",' ||
                         'hh17'  || ':"' || log_rec.hh17  || '",' ||
                         'hh18'  || ':"' || log_rec.hh18  || '",' ||
                         'hh19'  || ':"' || log_rec.hh19  || '",' ||
                         'hh20'  || ':"' || log_rec.hh20  || '",' ||
                         'hh21'  || ':"' || log_rec.hh21  || '",' ||
                         'hh22'  || ':"' || log_rec.hh22  || '",' ||
                         'hh23'  || ':"' || log_rec.hh23  || '"';
        o_cnt    := log_rec.all_cnt;
        o_gokei  := log_rec.gokei;
        o_avg    := log_rec.avg_cnt;
      end loop;

    when 'S' then
      -- データ取得
      w_cnt := 0;
      for  log_rec in log_cur_s(i_cid, i_ymd, i_ssl, i_pos, i_cnt) loop

        w_cnt := w_cnt + 1;
        o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                         'total' || ':"' || log_rec.total || '",' ||
                         'rate'  || ':"' || log_rec.rate  || '",' ||
                         'hh00'  || ':"' || log_rec.hh00  || '",' ||
                         'hh01'  || ':"' || log_rec.hh01  || '",' ||
                         'hh02'  || ':"' || log_rec.hh02  || '",' ||
                         'hh03'  || ':"' || log_rec.hh03  || '",' ||
                         'hh04'  || ':"' || log_rec.hh04  || '",' ||
                         'hh05'  || ':"' || log_rec.hh05  || '",' ||
                         'hh06'  || ':"' || log_rec.hh06  || '",' ||
                         'hh07'  || ':"' || log_rec.hh07  || '",' ||
                         'hh08'  || ':"' || log_rec.hh08  || '",' ||
                         'hh09'  || ':"' || log_rec.hh09  || '",' ||
                         'hh10'  || ':"' || log_rec.hh10  || '",' ||
                         'hh11'  || ':"' || log_rec.hh11  || '",' ||
                         'hh12'  || ':"' || log_rec.hh12  || '",' ||
                         'hh13'  || ':"' || log_rec.hh13  || '",' ||
                         'hh14'  || ':"' || log_rec.hh14  || '",' ||
                         'hh15'  || ':"' || log_rec.hh15  || '",' ||
                         'hh16'  || ':"' || log_rec.hh16  || '",' ||
                         'hh17'  || ':"' || log_rec.hh17  || '",' ||
                         'hh18'  || ':"' || log_rec.hh18  || '",' ||
                         'hh19'  || ':"' || log_rec.hh19  || '",' ||
                         'hh20'  || ':"' || log_rec.hh20  || '",' ||
                         'hh21'  || ':"' || log_rec.hh21  || '",' ||
                         'hh22'  || ':"' || log_rec.hh22  || '",' ||
                         'hh23'  || ':"' || log_rec.hh23  || '"';
        o_cnt    := log_rec.all_cnt;
        o_gokei  := log_rec.gokei;
        o_avg    := log_rec.avg_cnt;
      end loop;

    when 'T' then
      -- データ取得
      w_cnt := 0;
      for  log_rec in log_cur_t(i_cid, i_ymd, i_ssl, i_pos, i_cnt) loop

        w_cnt := w_cnt + 1;
        o_info(w_cnt) := 'api'   || ':"' || log_rec.api   || '",' ||
                         'total' || ':"' || log_rec.total || '",' ||
                         'rate'  || ':"' || log_rec.rate  || '",' ||
                         'hh00'  || ':"' || log_rec.hh00  || '",' ||
                         'hh01'  || ':"' || log_rec.hh01  || '",' ||
                         'hh02'  || ':"' || log_rec.hh02  || '",' ||
                         'hh03'  || ':"' || log_rec.hh03  || '",' ||
                         'hh04'  || ':"' || log_rec.hh04  || '",' ||
                         'hh05'  || ':"' || log_rec.hh05  || '",' ||
                         'hh06'  || ':"' || log_rec.hh06  || '",' ||
                         'hh07'  || ':"' || log_rec.hh07  || '",' ||
                         'hh08'  || ':"' || log_rec.hh08  || '",' ||
                         'hh09'  || ':"' || log_rec.hh09  || '",' ||
                         'hh10'  || ':"' || log_rec.hh10  || '",' ||
                         'hh11'  || ':"' || log_rec.hh11  || '",' ||
                         'hh12'  || ':"' || log_rec.hh12  || '",' ||
                         'hh13'  || ':"' || log_rec.hh13  || '",' ||
                         'hh14'  || ':"' || log_rec.hh14  || '",' ||
                         'hh15'  || ':"' || log_rec.hh15  || '",' ||
                         'hh16'  || ':"' || log_rec.hh16  || '",' ||
                         'hh17'  || ':"' || log_rec.hh17  || '",' ||
                         'hh18'  || ':"' || log_rec.hh18  || '",' ||
                         'hh19'  || ':"' || log_rec.hh19  || '",' ||
                         'hh20'  || ':"' || log_rec.hh20  || '",' ||
                         'hh21'  || ':"' || log_rec.hh21  || '",' ||
                         'hh22'  || ':"' || log_rec.hh22  || '",' ||
                         'hh23'  || ':"' || log_rec.hh23  || '"';
        o_cnt    := log_rec.all_cnt;
        o_gokei  := log_rec.gokei;
        o_avg    := log_rec.avg_cnt;
      end loop;

    else
      null;

  end case;

  o_rtncd := 0;			-- 正常終了
exception
  when others then
    w_msg := substrb(sqlerrm, 1, 500);
--    insert into error_log values(sysdate, 'P_GET_TIME_FUNC', i_cid, w_msg);
--    commit;
    o_rtncd := 7000;
end P_GET_TIME_FUNC;


---------------------------------------------------------------------------------------------------------------
-- ホスト別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_HOST (
  i_cid		in	varchar2,		-- 企業ID
  i_month	in	varchar2,		-- 検索期間（1:１ヶ月、3:３ヶ月）
  i_ym		in	varchar2,		-- 検索年月（yyyymm）
  i_order	in	number,			-- 検索順位（1～指定順位まで出力される）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_info	out	tbl_type		-- 検索情報（API名,日合計,00時～23時）
) is

  --
  -- １ヶ月検索用カーソル
  --
  cursor log_cur_1 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_order		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select * from (
      select o.*, count(*) over () all_cnt, row_number() over (order by rnk, host) rnum
      from (select l.*
        from (select l.host,
                     sum(l.cnt) cnt,
                     rank() over(order by sum(l.cnt) desc) rnk
              from host_top100_log l
              where decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
                and l.ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
                -- and l.ym between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
              group by l.host
        ) l
        where rnk <= i_order
      ) o
    )
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  --
  -- ３ヶ月検索用カーソル
  --
  cursor log_cur_3 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_order		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select * from (
      select o.*, count(*) over () all_cnt, row_number() over (order by rnk, host) rnum
      from (select l.*
        from (select l.host,
                     sum(l.cnt) cnt,
                     rank() over(order by sum(l.cnt) desc) rnk
              from host_top100_log l
              where decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
                -- and l.ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
                and l.ym between nvl(to_char(add_months(to_date(i_ym, 'yyyymm'), -2),'yyyymm'), to_char(add_months(sysdate, -2),'yyyymm')) and nvl(i_ym, to_char(sysdate,'yyyymm'))
              group by l.host
        ) l
        where rnk <= i_order
      ) o
    )
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  -- ワーク変数
  w_cnt		pls_integer;
  w_msg		varchar2(500);

begin
  -- クリア
  o_rtncd    := 0;
  o_cnt      := 0;

  if i_month = '1' then
    -- データ取得
    w_cnt := 0;
    for  log_rec in log_cur_1(i_cid, chg_ym(i_ym), i_order, i_pos, i_cnt) loop
      w_cnt := w_cnt + 1;
      o_info(w_cnt) := 'rank' || ':"' || log_rec.rnk || '",' ||
                       'host' || ':"' || log_rec.host || '",' ||
                       'cnt'  || ':"' || log_rec.cnt  || '"';
      o_cnt := log_rec.all_cnt;
    end loop;
  else
    -- データ取得
    w_cnt := 0;
    for  log_rec in log_cur_3(i_cid, chg_ym(i_ym), i_order, i_pos, i_cnt) loop
      w_cnt := w_cnt + 1;
      o_info(w_cnt) := 'rank' || ':"' || log_rec.rnk || '",' ||
                       'host' || ':"' || log_rec.host || '",' ||
                       'cnt'  || ':"' || log_rec.cnt  || '"';
      o_cnt := log_rec.all_cnt;
    end loop;
  end if;

  o_rtncd := 0;			-- 正常終了
exception
  when others then
    w_msg := substrb(sqlerrm, 1, 500);
--    insert into error_log values(sysdate, 'P_GET_HOST', i_cid, w_msg);
--    commit;
    o_rtncd := 7000;
end P_GET_HOST;


---------------------------------------------------------------------------------------------------------------
-- 無償版API月別アクセス件数取得
---------------------------------------------------------------------------------------------------------------
procedure P_GET_FAPI (
  i_cid		in	varchar2,		-- 企業ID
  i_ym		in	varchar2,		-- 検索年月（yyyymm）
  i_pos		in	number,			-- 取得位置
  i_cnt		in	number,			-- 取得件数
  o_rtncd	out	number,			-- リターンコード
  o_cnt		out	number,			-- 全データ件数
  o_info	out	tbl_type		-- 検索情報（企業ID, 合計）
) is

  --
  -- 全体、１ヶ月検索用カーソル
  --
  cursor log_cur_t_1 (
    i_cid		in	varchar2,
    i_ym		in	varchar2,
    i_pos		in	number,
    i_cnt		in	number
  ) is
    select p.*
    from (
      select o.*,
             count(*) over () all_cnt,
             row_number() over (order by dispnum) rnum
      from (select cid,api, dispnum, ym, total, min_ym, max_ym, to_number(to_char(last_day(to_date(ym, 'YYYYMM')), 'dd')) sum_cnt
        from (
          select a.cid,nvl(a.ym, i_ym) ym, b.api, b.dispnum, nvl(a.total, 0) total, nvl(a.min_ym, i_ym) min_ym, nvl(a.max_ym, i_ym) max_ym
          from
          (select l.cid,l.ym, '全体' api, 1 dispnum, sum(nvl(l.total, 0)) total, min(l.ym) min_ym, max(l.ym) max_ym
          from api20_date_log l, api20_mst m
          where l.api = m.api
            and l.cid in (select cid from api20ninsyo.fapi20_corp_mst)
            and decode(i_cid, null, 1, instr(i_cid, l.cid)) != 0
            and ym = nvl(i_ym, to_char(sysdate,'yyyymm'))
          group by l.cid,l.ym) a,
          (select '全体' api,
                  1 dispnum
           from dual) b
          where a.api(+) = b.api
        ) l
      ) o
    ) p
    where rnum between nvl(i_pos, 1) and (nvl(i_pos, 1) + nvl(i_cnt, 999999) -1)
    order by rnum;

  -- ワーク変数
  w_cnt		pls_integer;
  w_msg		varchar2(500);

begin
  -- クリア
  o_rtncd    := 0;
  o_cnt      := 0;

  -- データ取得
  w_cnt := 0;
  for  log_rec in log_cur_t_1 (i_cid, chg_ym(i_ym),  i_pos, i_cnt) loop
    w_cnt := w_cnt + 1;
    o_info(w_cnt) := 'cid'   || ':"' || log_rec.cid   || '",' ||
                     'total' || ':"' || log_rec.total || '"';
    o_cnt    := log_rec.all_cnt;
  end loop;

  o_rtncd := 0;			-- 正常終了
exception
  when others then
    w_msg := substrb(sqlerrm, 1, 500);
--    insert into error_log values(sysdate, 'P_GET_FAPI', i_cid, w_msg);
--    commit;
    o_rtncd := 7000;
end P_GET_FAPI;


END p_api_log_pkg;