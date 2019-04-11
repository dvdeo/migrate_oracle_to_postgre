CREATE OR REPLACE PACKAGE "API20NINSYO".p_api20_referer_pkg AS

-- 変数定義
TYPE tbl_type    IS TABLE OF varchar2(4000)
        INDEX BY BINARY_INTEGER;    -- 配列変数タイプ

/*     API2.0リファラー更新プロシージャ           */
/*     変更日            担当        内容         */
/*     2011/04/11        蛯澤        新規作成     */

procedure p_referer_updt (
  i_kbn          in     char,        -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid          in     varchar2,    -- ユーザID
  i_cid          in out varchar2,    -- 企業ID
  i_key_num      in out number,      -- キー番号
  i_referer      in out varchar2,    -- リファラー
  i_service_name in out varchar2,    -- サービス
  i_pos          in     number,      -- 取得位置（複数検索時指定）
  i_cnt          in     number,      -- 取得件数（複数検索時指定）
  o_ins_dt       out    char,        -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out    char,        -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out    char,        -- リターンコード
                                     --    '0000'：正常終了
                                     --    '0001'：企業ID無しエラー
                                     --    '0003'：リファラー有りエラー
                                     --    '0004'：ユーザーID無しエラー
                                     --    '0099'：更新区分エラー
                                     --    '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
                                     --     cid:xxxxx,referer:xxxxx,api_key:xxxxx,enc_api_key:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
);

end p_api20_referer_pkg;
/


CREATE OR REPLACE PACKAGE BODY "API20NINSYO".p_api20_referer_pkg AS

/*******************************************************************************/
/*                                                                             */
/*     API2.0リファラーテーブル更新プロシージャ                                */
/*                                                                             */
/*     変更日           担当        内容                                       */
/*     2011/04/11       蛯澤        新規作成                                   */
/*     2014/04/21       細谷        AUTH_NOREF_MVIEWのREFRESH追加              */
/*                                                                             */
/*     入力：企業ID                                                            */
/*     出力：リターンコード                                                    */
/*       '0000'：正常終了                                                      */
/*       '0001'：ADID無しエラー                                                */
/*       '0002'：ADID有りエラー                                                */
/*       '0099'：更新区分エラー                                                */
/*       '7001'：その他エラー                                                  */
/*                                                                             */
/*******************************************************************************/
procedure p_referer_updt (
  i_kbn          in     char,        -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid          in     varchar2,    -- ユーザID
  i_cid          in out varchar2,    -- 企業ID
  i_key_num      in out number,      -- キー番号
  i_referer      in out varchar2,    -- リファラー
  i_service_name in out varchar2,    -- サービス
  i_pos          in     number,      -- 取得位置（複数検索時指定）
  i_cnt          in     number,      -- 取得件数（複数検索時指定）
  o_ins_dt       out    char,        -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out    char,        -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out    char,        -- リターンコード
                                     --    '0000'：正常終了
                                     --    '0001'：企業ID無しエラー
                                     --    '0003'：リファラー有りエラー
                                     --    '0004'：ユーザーID無しエラー
                                     --    '0099'：更新区分エラー
                                     --    '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
                                     --     cid:xxxxx,referer:xxxxx,api_key:xxxxx,enc_api_key:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
) is

  -- リファラーテーブルカーソル（複数件検索用）
  CURSOR rf_search(i_cid          in    varchar2,
                   i_referer      in    varchar2,
                   i_service_name in    varchar2,
                   i_pos          in    number,
                   i_cnt          in    number) IS
    select * from (
      select cid,
             key_num,
             referer,
             service_name,
             to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(upd_dt, 'yyyymmddhh24miss') upd_dt,
             all_cnt,
             row_number() over (order by cid, key_num) rnum
      from (
        select cid,
               key_num,
               referer,
               service_name,
               ins_dt,
               upd_dt,
               count(*) over () all_cnt
        from api20_referer_tbl
        where decode(i_cid,          null, 1, instr(cid,         i_cid))           != 0
          and decode(i_referer,      null, 1, instr(referer,     i_referer))       != 0
          and decode(i_service_name, null, 1, instr(service_name,i_service_name))  != 0
      )
    )
    where rnum between i_pos and (i_pos + i_cnt -1)
    order by rnum;

  -- リファラーテーブルカーソル（更新時企業ID確認）
  CURSOR rf_cur(i_cid      in    varchar2,
                i_key_num  in    number ) IS
      select cid,
             key_num,
             referer,
             service_name,
             to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
      from   api20_referer_tbl
      where  cid     = i_cid
      and    key_num = i_key_num
      for update;

  rf_rec             rf_cur%ROWTYPE;

  -- リファラーテーブルカーソル（登録時リファラー確認）
  CURSOR rf_unique(i_cid     in varchar2,
                   i_referer in varchar2) IS
      select cid,
             referer
      from   api20_referer_tbl
      where  cid     = i_cid
      and    referer = i_referer;

  rf_unique_rec             rf_unique%ROWTYPE;


  -- API企業マスタカーソル
  CURSOR api_corp_cur(i_cid in char) is
    select cid,
           s_date,
           e_date
    from api20_corp_mst
    where cid = i_cid;

  api_corp_rec        api_corp_cur%ROWTYPE;

  -- ワーク変数
  w_cnt          pls_integer;    -- 取得データ件数
  w_rtncd        char(4);        -- リターンコード
  w_msg          varchar2(200);  -- エラーメッセージ
  w_proc_rtncd   char(4);        -- リターンコード

BEGIN
  -- クリア
  o_rtncd   := '0000';
  o_err_msg := null;
  o_cnt     := 0;

  w_cnt     := 0;
  w_rtncd   := '0000';


  -- 複数件指定処理
  if i_kbn = 'S' and i_key_num is null then
    for rf_srch_rec in rf_search(i_cid,
                                 i_referer,
                                 i_service_name,
                                 i_pos,
                                 i_cnt) loop
      w_cnt := w_cnt + 1;
      o_info(w_cnt) := 'cid'          || ':"' || rf_srch_rec.cid          || '",' ||
                       'key_num'      || ':"' || rf_srch_rec.key_num      || '",' ||
                       'referer'      || ':"' || rf_srch_rec.referer      || '",' ||
                       'service_name' || ':"' || rf_srch_rec.service_name || '",' ||
                       'ins_dt'       || ':"' || rf_srch_rec.ins_dt       || '",' ||
                       'upd_dt'       || ':"' || rf_srch_rec.upd_dt       || '"';
      o_cnt := rf_srch_rec.all_cnt;
    end loop;

    o_rtncd := '0000';            -- 正常終了

  else
    -- １REFERER指定処理
    open api_corp_cur(i_cid);    -- API20_CORP_MSTに企業IDがあるかどうか
    fetch api_corp_cur into api_corp_rec;
    if api_corp_cur%FOUND then

        open rf_cur(i_cid,i_key_num);    -- API20_REFERER_TBLにCIDとKEY_NUMがあるかどうか
        fetch rf_cur into rf_rec;
        if rf_cur%FOUND then             -- API20_REFERER_TBLにCIDが該当する場合

            case i_kbn
              when 'S' then
                -- POS=1以外指定チェック
                if i_pos != 1 then
                    i_cid           := null;                -- 企業ID
                    i_key_num       := null;                -- キー
                    i_referer       := null;                -- リファラー
                    i_service_name  := null;                -- サービス名
                    o_ins_dt        := null;                -- 登録日（YYYYMMDDHHMMSS）
                    o_upd_dt        := null;                -- 更新日（YYYYMMDDHHMMSS）
                else
                    i_cid           := rf_rec.cid;          -- 企業ID
                    i_key_num       := rf_rec.key_num;      -- キー
                    i_referer       := rf_rec.referer;      -- リファラー
                    i_service_name  := rf_rec.service_name; -- サービス名
                    o_ins_dt        := rf_rec.ins_dt;       -- 登録日（YYYYMMDDHHMMSS）
                    o_upd_dt        := rf_rec.upd_dt;       -- 更新日（YYYYMMDDHHMMSS）

                  w_cnt := w_cnt + 1;
                  o_info(w_cnt) := 'cid'         || ':"' || rf_rec.cid            || '",' ||
                                   'key_num'     || ':"' || rf_rec.key_num        || '",' ||
                                   'referer'     || ':"' || rf_rec.referer        || '",' ||
                                   'service_name'|| ':"' || rf_rec.service_name   || '",' ||
                                   'ins_dt'      || ':"' || rf_rec.ins_dt         || '",' ||
                                   'upd_dt'      || ':"' || rf_rec.upd_dt         || '"';
                  o_cnt := 1;
                end if;
                w_rtncd := '0000';
                o_rtncd := w_rtncd;

              when 'I' then
                    w_rtncd := '0003';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'REFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, 'リファラー有りエラー');
                    commit;

              when 'U' then
                -- APIキーテーブルデータ更新
                update api20_referer_tbl
                  set referer      = i_referer,       -- 更新用リファラー
                      key_num      = i_key_num,       -- キー
                      service_name = i_service_name,  -- サービス名
                      upd_dt       = sysdate          -- 更新日（YYYYMMDDHHMMSS）
                  where CURRENT OF rf_cur;
                w_rtncd := '0000';
                o_rtncd := w_rtncd;
                insert into api20_tbl_updt_log
                values(sysdate, 'REFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
                commit;

                P_REFRESH( 'AUTH_MVIEW', w_proc_rtncd );

                -- テーブル更新ログ書き込み
                insert into api20_tbl_updt_log
                values(sysdate, 'REFERER','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                commit;

                P_REFRESH( 'AUTH_NOREF_MVIEW', w_proc_rtncd );

                -- テーブル更新ログ書き込み
                insert into api20_tbl_updt_log
                values(sysdate, 'REFERER','NOREF', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                commit;

              when 'D' then
                   -- APIキーテーブルデータ削除
                   delete from api20_referer_tbl
                   where CURRENT OF rf_cur;
                   commit;
                w_rtncd := '0000';
                o_rtncd := w_rtncd;
                insert into api20_tbl_updt_log
                values(sysdate, 'REFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
                commit;

                P_REFRESH( 'AUTH_MVIEW', w_proc_rtncd );

                -- テーブル更新ログ書き込み
                insert into api20_tbl_updt_log
                values(sysdate, 'REFERER','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                commit;

                P_REFRESH( 'AUTH_NOREF_MVIEW', w_proc_rtncd );

                -- テーブル更新ログ書き込み
                insert into api20_tbl_updt_log
                values(sysdate, 'REFERER','NOREF', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                commit;

              else
                w_rtncd := '0099';
              end case;

        else   -- API20_REFERER_TBLにCIDが該当しない場合

              case i_kbn
                when 'S' then
                    w_rtncd := '0002';
                    o_rtncd := w_rtncd;

                when 'I' then
                    open rf_unique(i_cid,i_referer);
                    fetch rf_unique into rf_unique_rec;
                    if rf_unique%FOUND then
                        w_rtncd := '0003';
                        o_rtncd := w_rtncd;
                        insert into api20_tbl_updt_log
                        values(sysdate, 'REFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, 'リファラー有りエラー');
                        commit;
                    else

                        -- KEY_NUM自動発番（KEY_NUMがNULLの場合）
                        if i_key_num is null then
                            select nvl(max(key_num), 0) into i_key_num
                            from api20_referer_tbl
                            where cid = i_cid;
                            i_key_num := i_key_num + 1;
                        end if;

                        -- リファラーテーブルデータ追加
                        insert into api20_referer_tbl
                        values(i_cid,              -- 企業ID
                               i_key_num,          -- キー
                               i_referer,          -- リファラー
                               i_service_name,     -- サービス名
                               sysdate,            -- 登録日（YYYYMMDDHHMMSS）
                               sysdate             -- 更新日（YYYYMMDDHHMMSS）
                        );
                        commit;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                        insert into api20_tbl_updt_log
                        values(sysdate, 'REFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
                        commit;

                        P_REFRESH( 'AUTH_MVIEW', w_proc_rtncd );

                        -- テーブル更新ログ書き込み
                        insert into api20_tbl_updt_log
                        values(sysdate, 'REFERER','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                        commit;

                        P_REFRESH( 'AUTH_NOREF_MVIEW', w_proc_rtncd );

                        -- テーブル更新ログ書き込み
                        insert into api20_tbl_updt_log
                        values(sysdate, 'REFERER','NOREF', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                        commit;

                    end if;
                    close rf_unique;

                when 'U' then
                    w_rtncd := '0002';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'REFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '該当データ無しエラー');
                    commit;

                when 'D' then
                    w_rtncd := '0002';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'REFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '該当データ無しエラー');
                    commit;

                else
                    w_rtncd := '0099';
                    o_rtncd := w_rtncd;
              end case;

        end if;
        close rf_cur;

    else
        w_rtncd := '0001';
        insert into api20_tbl_updt_log
        values(sysdate, 'REFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '企業ID無しエラー');
        commit;

        o_rtncd := w_rtncd;

    end if;
    close api_corp_cur;

  end if;
  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
    values(sysdate,'REFERER',null, i_kbn, i_uid, i_cid, w_rtncd, '処理完了');
  commit;
  o_rtncd := w_rtncd;
  o_err_msg := null;

EXCEPTION
  when others then
    rollback;
    w_rtncd    := '7001';
    w_msg          := substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'REFERER',null, i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;

END p_referer_updt;
END p_api20_referer_pkg;