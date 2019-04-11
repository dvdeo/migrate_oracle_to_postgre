CREATE OR REPLACE PROCEDURE "API20NINSYO".p_smartphone_mst_get (
  i_ua         in    varchar2,        -- ユーザエージェント
  o_info       out   typ_ret_to_php,  -- 検索情報
  o_rtncd      out   char             -- リターンコード
                                      --    '00000'：正常終了
                                      --    '12001'：該当データ無し
                                      --    '17003'：その他エラー
) is

  cursor sp_mst_cur (i_ua in  varchar2) is
    select
      id,
      f_chg_column('nm')    ||':"'|| nm                ||'",'||    -- 名称
      f_chg_column('col_01')||':"'|| nvl(col_01,'000') ||'",'||    -- キャリア
      f_chg_column('col_02')||':"'|| nvl(col_02,'0')   ||'",'||    -- 地図表示サイズ(縦)
      f_chg_column('col_03')||':"'|| nvl(col_03,'0')   ||'",'||    -- 地図表示サイズ(横)
      f_chg_column('col_04')||':"'|| nvl(col_04,'0')   ||'",'||    -- px(縦)
      f_chg_column('col_05')||':"'|| nvl(col_05,'0')   ||'",'||    -- px(横)
      f_chg_column('col_06')||':"'|| nvl(col_06,'0')   ||'",'||    -- dp(縦)
      f_chg_column('col_07')||':"'|| nvl(col_07,'0')   ||'",'||    -- dp(横)
      f_chg_column('col_08')||':"'|| nvl(col_08,'000') ||'",'||    -- ピクセル密度
      f_chg_column('col_09')||':"'|| nvl(col_09,'0')   ||'",'||    -- dpi
      f_chg_column('col_10')||':"'|| nvl(col_10,'0')   ||'",'||    -- density
      f_chg_column('flg_01')||':"'|| nvl(flg_01,'0')   ||'",'||    -- 地図・ご当地アプリ対応フラグ
      f_chg_column('flg_02')||':"'|| nvl(flg_02,'0')   ||'",'||    -- ウィジェットアプリ対応フラグ
      f_chg_column('flg_03')||':"'|| nvl(flg_03,'N')   ||'",'||    -- 地図・ご当地アプリのマーケット遷移先
      f_chg_column('flg_04')||':"'|| nvl(flg_04,'N')   ||'",'||    -- ウィジェットアプリのマーケット遷移先
      f_chg_column('flg_05')||':"'|| nvl(flg_05,'')    ||'",'||    -- アプリ種別識別フラグ
      f_chg_column('flg_06')||':"'|| nvl(flg_06,'0')   ||'",'||    -- 住宅地図(運輸)フラグ
      f_chg_column('flg_07')||':"'|| nvl(flg_07,'0')   ||'",'||    -- 住宅地図(建築)フラグ
      f_chg_column('flg_10')||':"'|| nvl(flg_10,'0')   ||'",'||    -- 住宅地図(ゼンリン)フラグ
      f_chg_column('flg_08')||':"'|| nvl(flg_08,'0')   ||'",'||    -- 海外アプリ対応フラグ
      f_chg_column('flg_09')||':"'|| nvl(flg_09,'0')   ||'",'||    -- 電話可否フラグ
      f_chg_column('flg_11')||':"'|| nvl(flg_11,'0')   ||'",'||    -- ドコモ地図ナビ自律航法対応フラグ
      f_chg_column('flg_12')||':"'|| nvl(flg_12,'0')   ||'",'||    -- 住宅地図アプリ種別識別フラグ
      f_chg_column('col_11')||':"'|| nvl(col_11,'')    ||'"'       -- スゴ得アプリ対象バージョン
      as sp_info
    from
      sp_mst
    where
      id = i_ua
      and  valid_flg = '1'
      ;
  sp_mst_rec    sp_mst_cur%ROWTYPE;

  -- 出力項目変数
  rtncd    char(5);         -- リターンコード

  -- 変数
  w_index  number := 0;


begin
  -- 初期化
  o_info := typ_ret_to_php();
  rtncd  := '00000';

  open sp_mst_cur(i_ua);
  fetch sp_mst_cur into sp_mst_rec;
  if sp_mst_cur%NOTFOUND then
    rtncd  := '12001';
  else
    o_info.extend;
    w_index  := o_info.last;
    o_info(w_index) := sp_mst_rec.sp_info;
  end if;
  close sp_mst_cur;

  o_rtncd	:= rtncd;

exception
  when others then
    o_rtncd	:= '17003';
end;