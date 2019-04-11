CREATE OR REPLACE PACKAGE "API20NINSYO".p_smartphone_mst_pkg AS

type tbl_type IS table of varchar2(4000)
  index by binary_integer;    -- 配列変数タイプ

procedure p_smartphone_mst_upd (
  i_kbn        in    char          ,  -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid        in    varchar2      ,  -- ユーザID
  i_ua         in    varchar2      ,  -- ユーザエージェント
  i_val        in    tbl_type      ,  -- 登録情報(配列)（属性名:属性値）
  o_rtncd      out   char          ,  -- リターンコード
                                        --  '0000'：正常終了
                                        --  '0001'：UA有りエラー
                                        --  '0002'：UA無しエラー
                                        --  '0099'：更新区分エラー
                                        --  '7001'：その他エラー
  o_err_msg    out   varchar2      , -- エラーメッセージ
  o_cnt        out   number        , -- 全データ件数
  o_info       out   tbl_type        -- 複数件返却情報（キー:バリュー形式）
);
END p_smartphone_mst_pkg;
/


CREATE OR REPLACE PACKAGE BODY "API20NINSYO".p_smartphone_mst_pkg AS
PROCEDURE p_smartphone_mst_upd (
  i_kbn        in    char          ,  -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid        in    varchar2      ,  -- ユーザID
  i_ua         in    varchar2      ,  -- ユーザエージェント
  i_val        in    tbl_type      ,  -- 登録情報(配列)（属性名:属性値）
  o_rtncd      out   char          ,  -- リターンコード
                                        --  '0000'：正常終了
                                        --  '0001'：UA有りエラー
                                        --  '0002'：UA無しエラー
                                        --  '0099'：更新区分エラー
                                        --  '7001'：その他エラー
  o_err_msg    out   varchar2      , -- エラーメッセージ
  o_cnt        out   number        , -- 全データ件数
  o_info       out   tbl_type        -- 複数件返却情報（キー:バリュー形式）
) is

  cursor sp_mst_search_cur (i_ua in  varchar2) is
    select
      'id'                  ||':"'|| id                ||'",'||    -- ID
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
      f_chg_column('col_11')||':"'|| nvl(col_11,'')    ||'",'||    -- スゴ得アプリ対象バージョン
      'valid_flg:"'|| nvl(valid_flg,'0') ||'"'                     -- 有効フラグ
      as sp_info
    from
      sp_mst
    where
      decode(i_ua, null, 1, instr(id, i_ua)) != 0
      ;
  sp_mst_search_rec    sp_mst_search_cur%ROWTYPE;

  cursor sp_mst_cur (i_ua in  varchar2) is
    select
      id
    from
      sp_mst
    where
      id = i_ua
    for update;

    sp_mst_rec  sp_mst_cur%ROWTYPE;


  -- 変数
  w_index        number := 0;
  w_rtncd        char(4);        -- リターンコード
  w_proc_rtncd   char(4);        -- リターンコード
  w_msg          varchar2(200);  -- エラーメッセージ
  w_val_tbl      func_split_type;
  w_sql          varchar2(4000);
  w_col          varchar2(4000); -- insert/update文列名
  w_val          varchar2(4000); -- insert/update文値
  c1             integer := 0;
  nrtnexecute    number;         --sql戻り値

begin
  -- 初期化
  w_rtncd   := '0000';
  o_rtncd   := '0000';
  o_err_msg := null;
  o_cnt     := 0;

  if i_kbn = 'S' then

    for sp_mst_search_rec in sp_mst_search_cur(i_ua) loop
      w_index := w_index + 1;
      o_info(w_index) := sp_mst_search_rec.sp_info;
    end loop;

    o_cnt   := o_info.count;

  else

    open sp_mst_cur(i_ua);
    fetch sp_mst_cur into sp_mst_rec;
    if sp_mst_cur%FOUND then
      case i_kbn
        when 'I' then
          w_rtncd := '0001';

          -- テーブル更新ログ書き込み
          insert into api20_tbl_updt_log
            values(sysdate, 'SP_MST','TABLE', i_kbn, i_uid, 'UA:'||i_ua, w_rtncd, 'UA有りエラー');
          commit;

        when 'U' then
          for i in i_val.first..i_val.last loop
            w_val_tbl   := func_split(i_val(i), ':');
            if w_val_tbl.count = 1 then
              w_val := w_val || f_chg_column(w_val_tbl(1),'1') ||'=null,';
            else
              w_val := w_val || f_chg_column(w_val_tbl(1),'1') ||'='''|| w_val_tbl(2) ||''',';
            end if;
          end loop;

          w_sql := 'update sp_mst set '|| w_val ||'UPD_DT = sysdate ';
          w_sql := w_sql ||'where id ='''|| i_ua || '''';
          --dbms_output.put_line('UPDSQL=' || w_sql);

          --CURSORのオープン
          c1 := dbms_sql.open_cursor;
          --sql文の解析
          dbms_sql.parse(c1 , w_sql , dbms_sql.native);
          --sql実行
          nrtnexecute := dbms_sql.execute( c1 );
          --cursorのクローズ
          dbms_sql.close_cursor(c1);

          commit;
          w_rtncd := '0000';

        when 'D' then
          delete from sp_mst
            where current of sp_mst_cur;
          w_rtncd := '0000';

      else
        w_rtncd := '0099';
      end case;

    else
      case i_kbn
        when 'I' then

          for i in i_val.first..i_val.last loop
            w_val_tbl   := func_split(i_val(i), ':');
            w_col := w_col || f_chg_column(w_val_tbl(1),'1') ||',';
            if w_val_tbl.count = 1 then
              w_val := w_val || 'null,';
            else
              w_val := w_val || '''' || w_val_tbl(2) ||''',';
            end if;

          end loop;

          w_sql := 'insert into sp_mst (ID,'|| w_col ||'INS_DT,UPD_DT) ';
          w_sql := w_sql || 'values(';
          w_sql := w_sql || '''' || i_ua  ||''',';
          w_sql := w_sql || w_val ||'sysdate,sysdate)';
          --dbms_output.put_line('INSSQL=' || w_sql);

          --CURSORのオープン
          c1 := dbms_sql.open_cursor;
          --sql文の解析
          dbms_sql.parse(c1 , w_sql , dbms_sql.native);
          --sql実行
          nrtnexecute := dbms_sql.execute( c1 );
          --cursorのクローズ
          dbms_sql.close_cursor(c1);

          commit;
          w_rtncd := '0000';

        when 'U' then
          w_rtncd := '0002';

          -- テーブル更新ログ書き込み
          insert into api20_tbl_updt_log
            values(sysdate, 'SP_MST','TABLE', i_kbn, i_uid, 'UA:'||i_ua, w_rtncd, 'UA無しエラー');
          commit;

        when 'D' then
          w_rtncd := '0002';

          -- テーブル更新ログ書き込み
          insert into api20_tbl_updt_log
            values(sysdate, 'SP_MST','TABLE', i_kbn, i_uid, 'UA:'||i_ua, w_rtncd, 'UA無しエラー');
          commit;

      else
        w_rtncd := '0099';
      end case;


    end if;
    close sp_mst_cur;

    -- 正常更新した場合は公開DBへREFRESH
    if w_rtncd = '0000' then
      -- テーブル更新ログ書き込み
      insert into api20_tbl_updt_log
        values(sysdate, 'SP_MST',null, i_kbn, i_uid , 'UA:'||i_ua, w_rtncd, null);
      commit;

      P_REFRESH( 'SP_MST', w_proc_rtncd );

      -- テーブル更新ログ書き込み
      insert into api20_tbl_updt_log
      values(sysdate, 'SP_MST','MVIEW', i_kbn, i_uid, 'UA:'||i_ua, w_proc_rtncd,null);
      commit;
    end if;

  end if;

  o_rtncd   := w_rtncd;
  o_err_msg := null;

exception
  when others then
    rollback;
    w_rtncd  := '7001';
    w_msg    := substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'SP_MST', null, i_kbn, i_uid, 'UA:'||i_ua, w_rtncd, w_msg);
    commit;
    o_rtncd   := w_rtncd;
    o_err_msg := w_msg;
  end p_smartphone_mst_upd;
end p_smartphone_mst_pkg;