CREATE OR REPLACE PACKAGE "API20NINSYO".p_api20_hosoku_pkg AS

-- 変数定義
TYPE tbl_type IS TABLE OF varchar2(4000)
      INDEX BY BINARY_INTEGER;   -- 配列変数タイプ

-- API認証補足テーブル更新プロシージャ
procedure p_api20_hosoku_tbl_updt (
  i_kbn             in      char,      -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid             in      varchar2,  -- ユーザID
  i_corp_id         in out  varchar2,  -- 企業ID
  i_key_num         in out  number,    -- キー番号
  i_hosoku_kbn      in out  varchar2,  -- 補足区分
  i_hosoku_title    in out  varchar2,  -- 補足タイトル
  i_hosoku_detail   in out  varchar2,  -- 補足内容
  i_userid          in out  varchar2,  -- 最終更新者
  i_pos             in      number,    -- 取得位置（複数検索時指定）
  i_cnt             in      number,    -- 取得件数（複数検索時指定）
  o_ins_dt          out     char,      -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt          out     char,      -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd           out     char,      -- リターンコード
                                       --    '0000'：正常終了
                                       --    '0001'：キー無しエラー
                                       --    '0002'：キー有りエラー
                                       --    '0099'：更新区分エラー
                                       --    '7001'：その他エラー
  o_err_msg        out   varchar2,     -- エラーメッセージ
  o_cnt            out   number,       -- 全データ件数
  o_info           out   tbl_type      -- 複数件返却情報（キー:バリュー形式）
                                       --     corp_id:xxxxx,key_num:xxxxx,hosoku_kbn:xxxxx,hosoku_title:xxxxx,hosoku_detail:xxxxx,userid:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
);

end p_api20_hosoku_pkg;
/


CREATE OR REPLACE PACKAGE BODY "API20NINSYO".p_api20_hosoku_pkg AS

-- API2.0認証補足テーブル更新プロシージャ
procedure p_api20_hosoku_tbl_updt (
  i_kbn             in      char,      -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid             in      varchar2,  -- ユーザID
  i_corp_id         in out  varchar2,  -- 企業ID
  i_key_num         in out  number,    -- キー番号
  i_hosoku_kbn      in out  varchar2,  -- 補足区分
  i_hosoku_title    in out  varchar2,  -- 補足タイトル
  i_hosoku_detail   in out  varchar2,  -- 補足内容
  i_userid          in out  varchar2,  -- 最終更新者
  i_pos             in      number,    -- 取得位置（複数検索時指定）
  i_cnt             in      number,    -- 取得件数（複数検索時指定）
  o_ins_dt          out     char,      -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt          out     char,      -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd           out     char,      -- リターンコード
                                       --    '0000'：正常終了
                                       --    '0001'：キー無しエラー
                                       --    '0002'：キー有りエラー
                                       --    '0099'：更新区分エラー
                                       --    '7001'：その他エラー
  o_err_msg         out     varchar2,  -- エラーメッセージ
  o_cnt             out     number,    -- 全データ件数
  o_info            out     tbl_type   -- 複数件返却情報（キー:バリュー形式）
                                       --     corp_id:xxxxx,key_num:xxxxx,hosoku_kbn:xxxxx,hosoku_title:xxxxx,hosoku_detail:xxxxx,userid:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
) is

  -- API2.0補足テーブルカーソル（複数件検索用）
  cursor hosoku_search(i_corp_id       in    varchar2,
                       i_hosoku_kbn    in    varchar2,
                       i_hosoku_title  in    varchar2,
                       i_hosoku_detail in    varchar2,
                       i_userid        in    varchar2,
                       i_pos           in    number,
                       i_cnt           in    number) is
    select * from (
      select a.corp_id,
             a.key_num,
             a.hosoku_kbn,
             a.hosoku_title,
             a.hosoku_detail,
             a.userid,
             z.usermei,
             to_char(a.ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(a.upd_dt, 'yyyymmddhh24miss') upd_dt,
             a.all_cnt,
             row_number() over (order by corp_id, key_num) rnum
      from (
        select corp_id,
               key_num,
               hosoku_kbn,
               hosoku_title,
               hosoku_detail,
               userid,
               ins_dt,
               upd_dt,
               count(*) over () all_cnt
        from api20_hosoku_tbl
        where decode(i_corp_id,       null, 1, instr(corp_id,       i_corp_id))       != 0
          and decode(i_hosoku_kbn,    null, 1, instr(hosoku_kbn,    i_hosoku_kbn))    != 0
          and decode(i_hosoku_title,  null, 1, instr(hosoku_title,  i_hosoku_title))  != 0
          and decode(i_hosoku_detail, null, 1, instr(hosoku_detail, i_hosoku_detail)) != 0
          and decode(i_userid,        null, 1, instr(userid,        i_userid))        != 0
      ) a , zdc_uid z where a.userid = z.userid
    )
    where rnum between i_pos and (i_pos + i_cnt -1)
    order by rnum;

  -- API2.0補足テーブルカーソル（ID指定更新用）
  cursor hosoku_cur(i_corp_id in char, i_key_num in number) is
    select corp_id,
           key_num,
           hosoku_kbn,
           hosoku_title,
           hosoku_detail,
           userid,
           to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
           to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
    from api20_hosoku_tbl
    where corp_id = i_corp_id
      and key_num = i_key_num
    for update;

  hosoku_rec        hosoku_cur%ROWTYPE;

  -- ユーザマスタカーソル
  CURSOR zdc_uid_cur(i_uid char)
  IS
    select userid,usermei
    from zdc_uid
    where userid = i_uid;

  zdc_uid_rec  zdc_uid_cur%ROWTYPE;

  -- ワーク変数
  w_cnt     pls_integer;    -- 取得データ件数
  w_rtncd   char(4);        -- リターンコード
  w_msg     varchar2(200);  -- エラーメッセージ
  w_usermei varchar2(40);   -- ユーザー名

BEGIN
  -- クリア
  o_rtncd   := '0000';
  o_err_msg := null;
  o_cnt     := 0;

  w_cnt     := 0;
  w_rtncd   := '0000';

  -- 検索指定・KEY_NUM指定チェック
  if i_kbn = 'S' and i_key_num is null then
        for hosoku_rec in hosoku_search(i_corp_id,
                                        i_hosoku_kbn,
                                        i_hosoku_title,
                                        i_hosoku_detail,
                                        i_userid,
                                        i_pos,
                                        i_cnt) loop

          w_cnt := w_cnt + 1;
          o_info(w_cnt) := 'corp_id'       || ':"' || hosoku_rec.corp_id       || '",' ||
                           'key_num'       || ':"' || hosoku_rec.key_num       || '",' ||
                           'hosoku_kbn'    || ':"' || hosoku_rec.hosoku_kbn    || '",' ||
                           'hosoku_title'  || ':"' || hosoku_rec.hosoku_title  || '",' ||
                           'hosoku_detail' || ':"' || hosoku_rec.hosoku_detail || '",' ||
                           'userid'        || ':"' || hosoku_rec.userid        || '",' ||
                           'usermei'       || ':"' || hosoku_rec.usermei       || '",' ||
                           'ins_dt'        || ':"' || hosoku_rec.ins_dt        || '",' ||
                           'upd_dt'        || ':"' || hosoku_rec.upd_dt        || '"';
          o_cnt := hosoku_rec.all_cnt;
        end loop;

        o_rtncd := 0;            -- 正常終了

  else
        -- １ユーザ指定処理
        open hosoku_cur(i_corp_id, i_key_num);
        fetch hosoku_cur into hosoku_rec;
        if hosoku_cur%FOUND then
            case i_kbn
              when 'S' then
                -- POS=1以外指定チェック
                if i_pos != 1 then
                  i_corp_id       := null;                      -- 企業ID
                  i_key_num       := null;                      -- キー
                  i_hosoku_kbn    := null;                      -- 補足区分
                  i_hosoku_title  := null;                      -- 補足タイトル
                  i_hosoku_detail := null;                      -- 補足内容
                  i_userid        := null;                      -- ユーザID
                  o_ins_dt        := null;                      -- 登録日（YYYYMMDDHHMMSS）
                  o_upd_dt        := null;                      -- 更新日（YYYYMMDDHHMMSS）
                else
                  i_corp_id       := hosoku_rec.corp_id;        -- 企業ID
                  i_key_num       := hosoku_rec.key_num;        -- キー
                  i_hosoku_kbn    := hosoku_rec.hosoku_kbn;     -- 補足区分
                  i_hosoku_title  := hosoku_rec.hosoku_title;   -- 補足タイトル
                  i_hosoku_detail := hosoku_rec.hosoku_detail;  -- 補足内容
                  i_userid        := hosoku_rec.userid;         -- ユーザID
                  o_ins_dt        := hosoku_rec.ins_dt;         -- 登録日（YYYYMMDDHHMMSS）
                  o_upd_dt        := hosoku_rec.upd_dt;         -- 更新日（YYYYMMDDHHMMSS）

                OPEN zdc_uid_cur(i_userid);      -- DBリンク越しに見ているテーブルを含めたSELECT ～FOR UPDATEは出来ないので、USERMEI表示はカーソルで制御
                fetch zdc_uid_cur into zdc_uid_rec;
                w_usermei := zdc_uid_rec.usermei;

                  w_cnt := w_cnt + 1;
                  o_info(w_cnt) := 'corp_id'       || ':"' || hosoku_rec.corp_id       || '",' ||
                                   'key_num'       || ':"' || hosoku_rec.key_num       || '",' ||
                                   'hosoku_kbn'    || ':"' || hosoku_rec.hosoku_kbn    || '",' ||
                                   'hosoku_title'  || ':"' || hosoku_rec.hosoku_title  || '",' ||
                                   'hosoku_detail' || ':"' || hosoku_rec.hosoku_detail || '",' ||
                                   'userid'        || ':"' || hosoku_rec.userid        || '",' ||
                                   'usermei'       || ':"' || w_usermei                || '",' ||
                                   'ins_dt'        || ':"' || hosoku_rec.ins_dt        || '",' ||
                                   'upd_dt'        || ':"' || hosoku_rec.upd_dt        || '"';
                  o_cnt := 1;
                end if;

              when 'I' then
                  w_rtncd := '0002';

              when 'U' then
                  update api20_hosoku_tbl
                    set corp_id         = i_corp_id,         -- 企業ID
                        key_num         = i_key_num,         -- キー
                        hosoku_kbn      = i_hosoku_kbn,      -- 補足区分
                        hosoku_title    = i_hosoku_title,    -- 補足タイトル
                        hosoku_detail   = i_hosoku_detail,   -- 補足詳細
                        userid          = i_userid,          -- ユーザID（ログインユーザ）
                        upd_dt          = sysdate            -- 更新日（YYYYMMDDHHMMSS）
                    where CURRENT OF hosoku_cur;
                  w_rtncd := '0000';

              when 'D' then
                  delete from api20_hosoku_tbl
                    where CURRENT OF hosoku_cur;
                  w_rtncd := '0000';

              else
                  w_rtncd := '0099';
              end case;
        else
            case i_kbn
              when 'S' then
                  w_rtncd := '0001';

              when 'I' then
                  -- KEY_NUM自動発番（KEY_NUMがNULLの場合）
                  if i_key_num is null then
                      select nvl(max(key_num), 0) into i_key_num
                      from api20_hosoku_tbl
                      where corp_id = i_corp_id;
                      i_key_num := i_key_num + 1;
                  end if;

                  insert into api20_hosoku_tbl
                    values(i_corp_id,         -- 企業ID
                           i_key_num,         -- キー
                           i_hosoku_kbn,      -- 補足区分
                           i_hosoku_title,    -- 補足タイトル
                           i_hosoku_detail,   -- 補足詳細
                           i_userid,          -- ユーザID（ログインユーザ）
                           sysdate,           -- 登録日（YYYYMMDDHHMMSS）
                           sysdate            -- 更新日（YYYYMMDDHHMMSS）
                    );
                  w_rtncd := '0000';

              when 'U' then
                  w_rtncd := '0001';

              when 'D' then
                  w_rtncd := '0001';

              else
                  w_rtncd := '0099';
             end case;

        end if;
        close hosoku_cur;

  end if;

  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
    values(sysdate, 'HOSOKU',null, i_kbn, i_uid, i_corp_id||' '||to_char(i_key_num), w_rtncd, null);
  commit;
  o_rtncd := w_rtncd;
  o_err_msg := null;

EXCEPTION
  when others then
    rollback;
    w_rtncd	:= '7001';
    w_msg      	:= substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'HOSOKU', null, i_kbn, i_uid, i_corp_id||' '||to_char(i_key_num), w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;
end p_api20_hosoku_tbl_updt;

end p_api20_hosoku_pkg;