p_fapi20_pkgCREATE OR REPLACE PACKAGE "API20NINSYO".p_fapi20_pkg AS

-- 変数定義
TYPE tbl_type IS TABLE OF varchar2(4000)
        INDEX BY BINARY_INTEGER;    -- 配列変数タイプ

/*     API2.0企業マスタ更新プロシージャ(無償版)   */
/*     変更日            担当        内容         */
/*     2014/05/09        細谷        新規作成     */
procedure p_corp_updt (
  i_kbn           in      char,      -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid           in      varchar2,  -- ユーザID
  i_cid           in out  varchar2,  -- 企業ID
  i_passwd        in out  varchar2,  -- パスワード
  i_cname         in out  varchar2,  -- 企業名
  i_cname_kana    in out  varchar2,  -- 企業名カナ
  i_addr          in out  varchar2,  -- 住所
  i_post          in out  varchar2,  -- 郵便番号
  i_tel           in out  varchar2,  -- 電話番号
  i_dept          in out  varchar2,  -- 部署名
  i_s_date        in out  varchar2,  -- サービス開始日付（YYYYMMDDHHMMSS）
  i_e_date        in out  varchar2,  -- サービス終了日付（YYYYMMDDHHMMSS）
  i_s_date_op     in      varchar2,  -- 開始日付検索条件（1:以前、2:一致、3:以降）
  i_e_date_op     in      varchar2,  -- 終了日付検索条件（1:以前、2:一致、3:以降）
  i_sales_id      in out  varchar2,  -- 担当営業ユーザID
  i_other_maddr   in out  varchar2,  -- 関係者メールアドレス
  i_end_flg       in out  varchar2,  -- 契約終了フラグ（0:利用中(デフォルト)、1:終了）
  i_usage         in out  varchar2,  -- 用途
  i_maddr         in out  varchar2,  -- メールアドレス
  i_hack_flg      in out  varchar2,  -- ハッカソンフラグ(0:ハッカソン(デフォルト)、1:ハッカソン以外、2：代理店（ゼンリン）)
  i_note          in out  varchar2,  -- 備考
  i_name          in out  varchar2,  -- 氏名
  i_user_flg      in out  varchar2,  -- 利用者フラグ（0:法人  1:個人）
  i_known_trigger in out  varchar2,  -- サイトを知ったきっかけ
  i_pos           in      number,    -- 取得位置（複数検索時指定）
  i_cnt           in      number,    -- 取得件数（複数検索時指定）
  o_ins_dt        out     char,      -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt        out     char,      -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd         out     char,      -- リターンコード
                                     --  '0000'：正常終了
                                     --  '0001'：企業ID無しエラー
                                     --  '0002'：企業ID有りエラー
                                     --  '0004'：ユーザID無しエラー
                                     --  '0099'：更新区分エラー
                                     --  '7001'：その他エラー
  o_err_msg       out     varchar2,  -- エラーメッセージ
  o_cnt           out     number,    -- 全データ件数
  o_info          out     tbl_type   -- 複数件返却情報（キー:バリュー形式）
);


/*     API2.0リファラー更新プロシージャ(無償版)   */
/*     変更日            担当        内容         */
/*     2014/05/09        細谷        新規作成     */
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
                                     --  '0000'：正常終了
                                     --  '0001'：企業ID無しエラー
                                     --  '0002'：該当データ無しエラー
                                     --  '0003'：リファラー有りエラー
                                     --  '0099'：更新区分エラー
                                     --  '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
                                     --     cid:xxxxx,referer:xxxxx,api_key:xxxxx,enc_api_key:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
);


/*     API2.0仮登録テーブル更新プロシージャ       */
/*     変更日            担当        内容         */
/*     2014/05/09        細谷        新規作成     */
procedure p_proreg_updt (
  i_kbn          in     char,        -- 更新区分（S:検索、I:登録、D:削除）
  i_id           in out varchar2,    -- ID
  i_maddr        in out varchar2,    -- メールアドレス
  o_ins_dt       out    char,        -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out    char,        -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out    char,        -- リターンコード
                                     --  '0000'：正常終了
                                     --  '0001'：該当データ無しエラー
                                     --  '0002'：ID有りエラー
                                     --  '0003'：メールアドレス有りエラー
                                     --  '0099'：更新区分エラー
                                     --  '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
                                     --     id:xxxxx,maddr:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
);


/*     API20本登録(無償版→有償版)プロシージャ    */
/*     変更日            担当        内容         */
/*     2014/05/09        細谷        新規作成     */
procedure p_reg (
  i_uid          in     varchar2,    -- ユーザID
  i_cid          in     varchar2,    -- 企業ID
  o_rtncd        out    char,        -- リターンコード
                                     --  '0000'：正常終了
                                     --  '0001'：企業ID無しエラー
                                     --  '0002'：企業ID有りエラー
                                     --  '7001'：その他エラー
  o_err_msg      out    varchar2     -- エラーメッセージ
);


/*     API2.0パスワード忘れ確認情報更新プロシージャ */
/*     変更日            担当        内容           */
/*     2014/05/09        川本        新規作成       */
procedure p_pwdcfm_updt (
  i_kbn          in     char,        -- 更新区分（S:検索、I:登録、D:削除）
  i_id           in out varchar2,    -- ID
  i_cid          in out varchar2,    -- 企業ID
  o_ins_dt       out    char,        -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out    char,        -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out    char,        -- リターンコード
                                     --  '0000'：正常終了
                                     --  '0001'：該当データ無しエラー
                                     --  '0002'：ID有りエラー
                                     --  '0003'：企業ID有りエラー
                                     --  '0099'：更新区分エラー
                                     --  '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
                                     --     id:xxxxx,maddr:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
);



end p_fapi20_pkg;
/


CREATE OR REPLACE PACKAGE BODY "API20NINSYO".p_fapi20_pkg AS

/*****************************************************************************************************************************************************/
/*                                                                                                                                                   */
/*     API2.0企業マスタ更新パッケージ(無償版)(本体部)                                                                                                */
/*                                                                                                                                                   */
/*     変更日            担当        内容                                                                                                            */
/*     2014/05/09        細谷        新規作成                                                                                                        */
/*     2014/07/29        細谷        api_corp_searchのorderby句変更                                                                                  */
/*     2014/07/30        細谷        api_corp_searchの結合条件変更                                                                                   */
/*     2014/08/29        川本        p_corp_updtにパラメータ追加（name:氏名, user_flg:利用者フラグ, known_trigger:サイトを知ったきっかけ）           */
/*                                   ハッカソンフラグのコメントに「2：代理店（ゼンリン）」を追加                                                     */
/*                                   p_proreg_updにて、更新区分=「削除」の場合、CIDを完全一致に変更（検索は、今まで通り部分一致）                    */
/*                                                                                                                                                   */
/*                                   p_regに企業マスタ(有償版)にない項目に「利用者フラグ」「サイトを知ったきっかけ」項目を用途欄にコロン区切りで追加 */
/*                                      変更前) 用途::メールアドレス::ハッカソン::備考                                                               */
/*                                      変更後) 用途::メールアドレス::ハッカソン::備考::利用者フラグ::サイトを知ったきっかけ                         */
/*                                   無償→有償に切り替わった場合でも無償版企業マスタ/リファラーテーブルにデータを残したままにする                   */
/*                                      fapi20_corp_mst.upd_dtは更新する。api20_tbl_updt_logの区分も'D'→'U'に変更する                               */
/*                                      fapi20_referer_tbl.upd_dtは更新する。api20_tbl_updt_logの区分も'D'→'U'に変更する                            */
/*                                                                                                                                                   */
/*                                   パスワード忘れ確認情報更新プロシージャ新規作成                                                                  */
/*                                                                                                                                                   */
/*****************************************************************************************************************************************************/

/*     API2.0企業マスタ更新プロシージャ(無償版)   */
/*     変更日            担当        内容         */
/*     2014/05/09        細谷        新規作成     */
PROCEDURE p_corp_updt (
  i_kbn           in      char,      -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid           in      varchar2,  -- ユーザID
  i_cid           in out  varchar2,  -- 企業ID
  i_passwd        in out  varchar2,  -- パスワード
  i_cname         in out  varchar2,  -- 企業名
  i_cname_kana    in out  varchar2,  -- 企業名カナ
  i_addr          in out  varchar2,  -- 住所
  i_post          in out  varchar2,  -- 郵便番号
  i_tel           in out  varchar2,  -- 電話番号
  i_dept          in out  varchar2,  -- 部署名
  i_s_date        in out  varchar2,  -- サービス開始日付（YYYYMMDDHHMMSS）
  i_e_date        in out  varchar2,  -- サービス終了日付（YYYYMMDDHHMMSS）
  i_s_date_op     in      varchar2,  -- 開始日付検索条件（1:以前、2:一致、3:以降）
  i_e_date_op     in      varchar2,  -- 終了日付検索条件（1:以前、2:一致、3:以降）
  i_sales_id      in out  varchar2,  -- 担当営業ユーザID
  i_other_maddr   in out  varchar2,  -- 関係者メールアドレス
  i_end_flg       in out  varchar2,  -- 契約終了フラグ（0:利用中(デフォルト、1:終了)）
  i_usage         in out  varchar2,  -- 用途
  i_maddr         in out  varchar2,  -- メールアドレス
  i_hack_flg      in out  varchar2,  -- ハッカソンフラグ(0:ハッカソン(デフォルト)、1:ハッカソン以外、2：代理店（ゼンリン）)
  i_note          in out  varchar2,  -- 備考
  i_name          in out  varchar2,  -- 氏名
  i_user_flg      in out  varchar2,  -- 利用者フラグ（0:法人  1:個人）
  i_known_trigger in out  varchar2,  -- サイトを知ったきっかけ
  i_pos           in      number,    -- 取得位置（複数検索時指定）
  i_cnt           in      number,    -- 取得件数（複数検索時指定）
  o_ins_dt        out     char,      -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt        out     char,      -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd         out     char,      -- リターンコード
                                     --  '0000'：正常終了
                                     --  '0001'：企業ID無しエラー
                                     --  '0002'：企業ID有りエラー
                                     --  '0004'：ユーザID無しエラー
                                     --  '0099'：更新区分エラー
                                     --  '7001'：その他エラー
  o_err_msg       out     varchar2,  -- エラーメッセージ
  o_cnt           out     number,    -- 全データ件数
  o_info          out     tbl_type   -- 複数件返却情報（キー:バリュー形式）
) IS
  -- API企業情報取得カーソル（複数件検索用）
  CURSOR api_corp_search(i_cid           in  varchar2,
                         i_passwd        in  varchar2,
                         i_cname         in  varchar2,
                         i_cname_kana    in  varchar2,
                         i_addr          in  varchar2,
                         i_post          in  varchar2,
                         i_tel           in  varchar2,
                         i_dept          in  varchar2,
                         i_s_date        in  varchar2,
                         i_e_date        in  varchar2,
                         i_s_date_op     in  varchar2,
                         i_e_date_op     in  varchar2,
                         i_sales_id      in  varchar2,
                         i_other_maddr   in  varchar2,
                         i_end_flg       in  varchar2,
                         i_usage         in  varchar2,
                         i_maddr         in  varchar2,
                         i_hack_flg      in  varchar2,
                         i_note          in  varchar2,
                         i_name          in  varchar2,
                         i_user_flg      in  varchar2,
                         i_known_trigger in  varchar2,
                         i_pos           in  number,
                         i_cnt           in  number
)
  IS
    SELECT * FROM (
        SELECT a.cid,
               a.passwd,
               a.cname,
               a.cname_kana,
               a.addr,
               a.post,
               a.tel,
               a.dept,
               to_char(a.s_date, 'yyyymmddhh24miss') S_DATE,
               to_char(a.e_date, 'yyyymmddhh24miss') E_DATE,
               a.sales_id,
               z.usermei,
               a.other_maddr,
               a.end_flg,
               a.usage,
               a.maddr,
               a.hack_flg,
               a.note,
               a.name,
               a.user_flg,
               a.known_trigger,
               to_char(a.ins_dt, 'yyyymmddhh24miss') INS_DT,
               to_char(a.upd_dt, 'yyyymmddhh24miss') UPD_DT,
               a.all_cnt,
               row_number() over (order by cid) rnum
               FROM (SELECT
                     cid,
                     passwd,
                     cname,
                     cname_kana,
                     addr,
                     post,
                     tel,
                     dept,
                     s_date,
                     e_date,
                     sales_id,
                     other_maddr,
                     end_flg,
                     usage,
                     maddr,
                     hack_flg,
                     note,
                     name,
                     user_flg,
                     known_trigger,
                     ins_dt,
                     upd_dt,
                     count(*) over () all_cnt
                     FROM fapi20_corp_mst
                     WHERE DECODE(i_cid,           null, 1, instr(cid,            ltrim(i_cid, '*')))    != 0
                       AND DECODE(i_passwd,        null, 1, instr(passwd,         i_passwd))             != 0
                       AND DECODE(i_cname,         null, 1, instr(cname,          i_cname))              != 0
                       AND DECODE(i_cname_kana,    null, 1, instr(cname_kana,     i_cname_kana))         != 0
                       AND DECODE(i_addr,          null, 1, instr(addr,           i_addr))               != 0
                       AND DECODE(i_post,          null, 1, instr(post,           i_post))               != 0
                       AND DECODE(i_tel,           null, 1, instr(tel,            i_tel))                != 0
                       AND DECODE(i_dept,          null, 1, instr(dept,           i_dept))               != 0
                       AND DECODE(i_sales_id,      null, 1, instr(sales_id,       i_sales_id))           != 0
                       AND DECODE(i_other_maddr,   null, 1, instr(other_maddr,    i_other_maddr))        != 0
                       AND DECODE(i_end_flg,       null, 1, instr(end_flg,        i_end_flg))            != 0
                       AND DECODE(i_usage,         null, 1, instr(usage,          i_usage))              != 0
                       AND DECODE(i_maddr,         null, 1, instr(maddr,          i_maddr))              != 0
                       AND DECODE(i_hack_flg,      null, 1, instr(hack_flg,       i_hack_flg))           != 0
                       AND DECODE(i_note,          null, 1, instr(note,           i_note))               != 0
                       AND DECODE(i_name,          null, 1, instr(name,           i_name))               != 0
                       AND DECODE(i_user_flg,      null, 1, instr(user_flg,       i_user_flg))           != 0
                       AND DECODE(i_known_trigger, null, 1, instr(known_trigger,  i_known_trigger))      != 0
                       AND CASE
                           WHEN i_s_date is not null and i_s_date_op is not null THEN
                                CASE
                                WHEN i_s_date_op = '1' THEN
                                     CASE WHEN trunc(to_date(to_char(s_date,'yyyymmddhh24miss'),'yyyymmddhh24miss')) <= trunc(to_date(i_s_date, 'yyyymmddhh24miss')) THEN 1 ELSE 0 END
                                WHEN i_s_date_op = '2' THEN
                                     CASE WHEN trunc(to_date(to_char(s_date,'yyyymmddhh24miss'),'yyyymmddhh24miss')) =  trunc(to_date(i_s_date, 'yyyymmddhh24miss')) THEN 1 ELSE 0 END
                                WHEN i_s_date_op = '3' THEN
                                     CASE WHEN trunc(to_date(to_char(s_date,'yyyymmddhh24miss'),'yyyymmddhh24miss')) >= trunc(to_date(i_s_date, 'yyyymmddhh24miss')) THEN 1 ELSE 0 END
                                ELSE 0 END
                           ELSE 1 END != 0
                       AND CASE
                           WHEN i_e_date is not null and i_e_date_op is not null THEN
                                CASE
                                WHEN i_e_date_op = '1' THEN
                                     CASE WHEN trunc(to_date(to_char(e_date,'yyyymmddhh24miss'),'yyyymmddhh24miss')) <= trunc(to_date(i_e_date, 'yyyymmddhh24miss')) THEN 1 ELSE 0 END
                                WHEN i_e_date_op = '2' THEN
                                     CASE WHEN trunc(to_date(to_char(e_date,'yyyymmddhh24miss'),'yyyymmddhh24miss')) =  trunc(to_date(i_e_date, 'yyyymmddhh24miss')) THEN 1 ELSE 0 END
                                WHEN i_e_date_op = '3' THEN
                                     CASE WHEN trunc(to_date(to_char(e_date,'yyyymmddhh24miss'),'yyyymmddhh24miss')) >= trunc(to_date(i_e_date, 'yyyymmddhh24miss')) THEN 1 ELSE 0 END
                                ELSE 0 END
                           ELSE 1 END != 0
                     ) a , zdc_uid z where a.sales_id = z.userid(+)
    )
    WHERE rnum between i_pos and (i_pos + i_cnt -1)
    ORDER BY rnum;




  -- API企業情報取得カーソル
  CURSOR api_corp_cur(i_cid in char)
  IS
    select  cid,
            passwd,
            cname,
            cname_kana,
            addr,
            post,
            tel,
            dept,
            to_char(s_date, 'yyyymmddhh24miss') s_date,
            to_char(e_date, 'yyyymmddhh24miss') e_date,
            sales_id,
            other_maddr,
            end_flg,
            usage,
            maddr,
            hack_flg,
            note,
            name,
            user_flg,
            known_trigger,
            to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
            to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
    from fapi20_corp_mst
    where cid = i_cid
    for update;

    api_corp_rec  api_corp_cur%ROWTYPE;

  -- ワーク変数
  w_msg          varchar2(200);   -- エラーメッセージ
  w_usermei      varchar2(40);    -- ユーザー名
  w_n_rtncd_mail number;          -- リターンコード(企業マスタ更新用メール送信プロシージャ用)
  w_c_rtncd_mail char(4);         -- リターンコード(企業マスタ更新用メール送信プロシージャ用)
  w_cnt          pls_integer;     -- 取得データ件数
  w_proc_rtncd   char(4);         -- リターンコード
  w_rtncd        char(4);         -- リターンコード

  -- ユーザマスタカーソル
  CURSOR zdc_uid_cur(i_sales_id in char)
  IS
    select userid,usermei
    from zdc_uid
    where userid = i_sales_id;

  zdc_uid_rec  zdc_uid_cur%ROWTYPE;


BEGIN
  -- うるう年補正（2/29 -> 2/28）
  if substr(i_s_date,5,4) = '0229' then
    i_s_date := substr(i_s_date,1,4) || '0228' || substr(i_s_date,9);
  end if;

  -- 初期化
  o_rtncd   := '0000';
  o_err_msg := null;
  o_cnt     := 0;
  w_cnt     := 0;
  w_rtncd   := '0000';
  w_usermei := null;

  --CIDの指定がない時->複数件抽出
  if i_kbn = 'S' and (i_cid is null or substr(i_cid, 1, 1) = '*') then
    FOR api_corp_search_rec in api_corp_search(i_cid,
                                               i_passwd,
                                               i_cname,
                                               i_cname_kana,
                                               i_addr,
                                               i_post,
                                               i_tel,
                                               i_dept,
                                               i_s_date,
                                               i_e_date,
                                               i_s_date_op,
                                               i_e_date_op,
                                               i_sales_id,
                                               i_other_maddr,
                                               i_end_flg,
                                               i_usage,
                                               i_maddr,
                                               i_hack_flg,
                                               i_note,
                                               i_name,
                                               i_user_flg,
                                               i_known_trigger,
                                               i_pos,
                                               i_cnt
                                               )
    LOOP
    w_cnt := w_cnt + 1;
    o_info(w_cnt) := 'cid'           || ':"' || api_corp_search_rec.cid           || '",' ||
                     'passwd'        || ':"' || api_corp_search_rec.passwd        || '",' ||
                     'cname'         || ':"' || api_corp_search_rec.cname         || '",' ||
                     'cname_kana'    || ':"' || api_corp_search_rec.cname_kana    || '",' ||
                     'addr'          || ':"' || api_corp_search_rec.addr          || '",' ||
                     'post'          || ':"' || api_corp_search_rec.post          || '",' ||
                     'tel '          || ':"' || api_corp_search_rec.tel           || '",' ||
                     'dept'          || ':"' || api_corp_search_rec.dept          || '",' ||
                     's_date'        || ':"' || api_corp_search_rec.s_date        || '",' ||
                     'e_date'        || ':"' || api_corp_search_rec.e_date        || '",' ||
                     'sales_id'      || ':"' || api_corp_search_rec.sales_id      || '",' ||
                     'usermei'       || ':"' || api_corp_search_rec.usermei       || '",' ||
                     'other_maddr'   || ':"' || api_corp_search_rec.other_maddr   || '",' ||
                     'end_flg'       || ':"' || api_corp_search_rec.end_flg       || '",' ||
                     'usage'         || ':"' || api_corp_search_rec.usage         || '",' ||
                     'maddr'         || ':"' || api_corp_search_rec.maddr         || '",' ||
                     'hack_flg'      || ':"' || api_corp_search_rec.hack_flg      || '",' ||
                     'note'          || ':"' || api_corp_search_rec.note          || '",' ||
                     'name'          || ':"' || api_corp_search_rec.name          || '",' ||
                     'user_flg'      || ':"' || api_corp_search_rec.user_flg      || '",' ||
                     'known_trigger' || ':"' || api_corp_search_rec.known_trigger || '",' ||
                     'ins_dt'        || ':"' || api_corp_search_rec.ins_dt        || '",' ||
                     'upd_dt'        || ':"' || api_corp_search_rec.upd_dt        || '"';


    o_cnt := api_corp_search_rec.all_cnt;
    END LOOP;

    o_rtncd   := '0000';
  else
    -- CIDを指定している場合->1件を抽出
    -- CID指定時のPOS=1以外指定チェック
    if i_kbn ='S' and i_pos != 1 then
      w_rtncd := '0000';
      o_rtncd := w_rtncd; --テスト用
      i_cid           := null;
      i_passwd        := null;
      i_cname         := null;
      i_cname_kana    := null;
      i_addr          := null;
      i_post          := null;
      i_tel           := null;
      i_dept          := null;
      i_s_date        := null;
      i_e_date        := null;
      i_sales_id      := null;
      i_other_maddr   := null;
      i_end_flg       := null;
      i_usage         := null;
      i_maddr         := null;
      i_hack_flg      := null;
      i_note          := null;
      i_name          := null;
      i_user_flg      := null;
      i_known_trigger := null;
      o_ins_dt        := null;
      o_upd_dt        := null;
    else
      -- CID指定処理
      -- CIDが見つかった場合
      open api_corp_cur(i_cid);
      fetch api_corp_cur into api_corp_rec;
      if api_corp_cur%FOUND then
        case i_kbn
        when 'S' then
          i_cid           := api_corp_rec.cid;
          i_passwd        := api_corp_rec.passwd;
          i_cname         := api_corp_rec.cname;
          i_cname_kana    := api_corp_rec.cname_kana;
          i_addr          := api_corp_rec.addr;
          i_post          := api_corp_rec.post;
          i_tel           := api_corp_rec.tel;
          i_dept          := api_corp_rec.dept;
          i_s_date        := api_corp_rec.s_date;
          i_e_date        := api_corp_rec.e_date;
          i_sales_id      := api_corp_rec.sales_id;
          i_other_maddr   := api_corp_rec.other_maddr;
          i_end_flg       := api_corp_rec.end_flg;
          i_usage         := api_corp_rec.usage;
          i_maddr         := api_corp_rec.maddr;
          i_hack_flg      := api_corp_rec.hack_flg;
          i_note          := api_corp_rec.note;
          i_name          := api_corp_rec.name;
          i_user_flg      := api_corp_rec.user_flg;
          i_known_trigger := api_corp_rec.known_trigger;
          o_ins_dt        := api_corp_rec.ins_dt;
          o_upd_dt        := api_corp_rec.upd_dt;

          OPEN zdc_uid_cur(i_sales_id);      -- DBリンク越しに見ているテーブルを含めたSELECT ?FOR UPDATEは出来ないので、USERMEI表示はカーソルで制御
          fetch zdc_uid_cur into zdc_uid_rec;
          w_usermei := zdc_uid_rec.usermei;
              w_cnt := w_cnt + 1;
              o_info(w_cnt) := 'cid'            || ':"' || api_corp_rec.cid           || '",' ||
                               'passwd'         || ':"' || api_corp_rec.passwd        || '",' ||
                               'cname'          || ':"' || api_corp_rec.cname         || '",' ||
                               'cname_kana'     || ':"' || api_corp_rec.cname_kana    || '",' ||
                               'addr'           || ':"' || api_corp_rec.addr          || '",' ||
                               'post'           || ':"' || api_corp_rec.post          || '",' ||
                               'tel'            || ':"' || api_corp_rec.tel           || '",' ||
                               'dept'           || ':"' || api_corp_rec.dept          || '",' ||
                               's_date'         || ':"' || api_corp_rec.s_date        || '",' ||
                               'e_date'         || ':"' || api_corp_rec.e_date        || '",' ||
                               'sales_id'       || ':"' || api_corp_rec.sales_id      || '",' ||
                               'usermei'        || ':"' || w_usermei                  || '",' ||
                               'other_maddr'    || ':"' || api_corp_rec.other_maddr   || '",' ||
                               'end_flg'        || ':"' || api_corp_rec.end_flg       || '",' ||
                               'usage'          || ':"' || api_corp_rec.usage         || '",' ||
                               'maddr'          || ':"' || api_corp_rec.maddr         || '",' ||
                               'hack_flg'       || ':"' || api_corp_rec.hack_flg      || '",' ||
                               'note'           || ':"' || api_corp_rec.note          || '",' ||
                               'name'           || ':"' || api_corp_rec.name          || '",' ||
                               'user_flg'       || ':"' || api_corp_rec.user_flg      || '",' ||
                               'known_trigger'  || ':"' || api_corp_rec.known_trigger || '",' ||
                               'ins_dt'         || ':"' || api_corp_rec.ins_dt        || '",' ||
                               'upd_dt'         || ':"' || api_corp_rec.upd_dt        || '"';
              o_cnt := 1;
              o_rtncd := '0000';

          close zdc_uid_cur;


        when 'I' then
          w_rtncd := '0002';
          o_rtncd := w_rtncd;
          -- テーブル更新ログ書き込み
          insert into api20_tbl_updt_log
          values(sysdate,'FMST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID有りエラー');
          commit;

        when 'U' then
          open zdc_uid_cur(i_sales_id);
          fetch zdc_uid_cur into zdc_uid_rec;
          if zdc_uid_cur%FOUND then

            -- API企業マスタデータ更新
            update fapi20_corp_mst
              set
                cid           = i_cid,                                   -- 企業ID
                passwd        = i_passwd,                                -- パスワード
                cname         = i_cname,                                 -- 企業名
                cname_kana    = i_cname_kana,                            -- 企業名カナ
                addr          = i_addr,                                  -- 住所
                post          = i_post,                                  -- 郵便番号
                tel           = i_tel,                                   -- 電話番号
                dept          = i_dept,                                  -- 部署
                s_date        = to_date(i_s_date, 'yyyymmddhh24miss'),   -- サービス開始日付（YYYYMMDDHHMMSS）
                e_date        = to_date(i_e_date, 'yyyymmddhh24miss'),   -- サービス終了日付（YYYYMMDDHHMMSS）
                sales_id      = i_sales_id,                              -- 担当営業ユーザID
                other_maddr   = i_other_maddr,                           -- メールアドレス
                end_flg       = nvl(i_end_flg,'0'),                      -- 契約終了フラグ（0:利用中、1:終了）
                usage         = i_usage,                                 -- 用途
                maddr         = i_maddr,                                 -- メールアドレス
                hack_flg      = i_hack_flg,                              -- ハッカソンフラグ(0:ハッカソン(デフォルト)、1:ハッカソン以外、2：代理店（ゼンリン）)
                note          = i_note,                                  -- 備考
                name          = i_name,                                  -- 氏名
                user_flg      = i_user_flg,                              -- 利用者フラグ（0:法人  1:個人）
                known_trigger = i_known_trigger,                         -- サイトを知ったきっかけ
                upd_dt        = sysdate                                  -- 更新日（YYYYMMDDHHMMSS）
              where CURRENT OF api_corp_cur;
              commit;

            w_rtncd := '0000';
            o_rtncd := w_rtncd;

            -- テーブル更新ログ書き込み
            insert into api20_tbl_updt_log
            values(sysdate,'FMST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, null);
            commit;

            P_REFRESH( 'FAUTH_MVIEW', w_proc_rtncd );

            -- テーブル更新ログ書き込み
            insert into api20_tbl_updt_log
            values(sysdate,'FMST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
            commit;

            -- API企業マスタ更新用メール送信
            fcorp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);

            if w_n_rtncd_mail <> 0 then
              if w_n_rtncd_mail = 1 then
                 w_c_rtncd_mail := '0001';
              else
                 w_c_rtncd_mail := '0009';
              end if;
            else
              w_c_rtncd_mail := '0000';
            end if;

            -- テーブル更新ログ書き込み
            insert into api20_tbl_updt_log
            values(sysdate, 'FMST','MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
            commit;

          else
            w_rtncd := '0004';
            o_rtncd := w_rtncd;
            -- テーブル更新ログ書き込み
            insert into api20_tbl_updt_log
            values(sysdate, 'FMST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, 'ユーザーID無しエラー（USERID:'||i_uid||')');
            commit;

          end if;

          close zdc_uid_cur;

        when 'D' then
          -- API企業マスタデータ削除
          -- API企業マスタ更新用メール送信
          fcorp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);

          if w_n_rtncd_mail <> 0 then
            if w_n_rtncd_mail = 1 then
              w_c_rtncd_mail := '0001';
            else
              w_c_rtncd_mail := '0009';
            end if;
          else
            w_c_rtncd_mail := '0000';
          end if;

          -- テーブル更新ログ書き込み
          insert into api20_tbl_updt_log
          values(sysdate,'FMST', 'MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
          commit;

          delete from fapi20_corp_mst
          where CURRENT OF api_corp_cur;

          --同じ企業IDのリファラーも同時に削除
          delete from fapi20_referer_tbl
          where cid = i_cid;

          w_rtncd := '0000';
          o_rtncd := w_rtncd;

          -- テーブル更新ログ書き込み
          insert into api20_tbl_updt_log
          values(sysdate, 'FMST','TABLE', i_kbn, i_uid, i_cid, w_rtncd,null);
          commit;

          P_REFRESH( 'FAUTH_MVIEW', w_proc_rtncd );

          -- テーブル更新ログ書き込み
          insert into api20_tbl_updt_log
          values(sysdate, 'FMST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
          commit;

        else
          w_rtncd := '0099';
          o_rtncd := w_rtncd;  --テスト用
        end case;

      else
        case i_kbn
        when 'S' then
          w_rtncd := '0001';
          o_rtncd := w_rtncd;

        when 'I' then
          open zdc_uid_cur(i_sales_id);
          fetch zdc_uid_cur into zdc_uid_rec;
          if zdc_uid_cur%FOUND then
             -- API企業マスタデータ追加
             insert into fapi20_corp_mst
               values(
                 i_cid,                                  -- 企業ID
                 i_passwd,                               -- パスワード
                 i_cname,                                -- 企業名
                 i_cname_kana,                           -- 企業名カナ
                 i_addr,                                 -- 住所
                 i_post,                                 -- 郵便番号
                 i_tel,                                  -- 電話番号
                 i_dept,                                 -- 部署
                 to_date(i_s_date, 'yyyymmddhh24miss'),  -- サービス開始日付（YYYYMMDDHHMMSS）
                 to_date(i_e_date, 'yyyymmddhh24miss'),  -- サービス終了日付（YYYYMMDDHHMMSS）
                 i_sales_id,                             -- 担当営業ユーザID
                 i_other_maddr,                          --メールアドレス
                 nvl(i_end_flg,'0'),                     -- 契約終了フラグ（0:利用中、1:終了）
                 i_usage,                                -- 用途
                 i_maddr,                                -- メールアドレス
                 nvl(i_hack_flg,'0'),                    -- ハッカソンフラグ(0:ハッカソン(デフォルト)、1:ハッカソン以外、2：代理店（ゼンリン）)
                 i_note,                                 -- 備考
                 sysdate,                                -- 登録日（YYYYMMDDHHMMSS）
                 sysdate,                                -- 更新日（YYYYMMDDHHMMSS）
                 i_name,                                 -- 氏名
                 nvl(i_user_flg,'0'),                    -- 利用者フラグ（0:法人  1:個人）
                 i_known_trigger                         -- サイトを知ったきっかけ
               );
             commit;
             w_rtncd := '0000';
             o_rtncd := w_rtncd;

             if w_rtncd = '0000' then
               -- テーブル更新ログ書き込み
               insert into api20_tbl_updt_log
               values(sysdate, 'FMST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd,null);
               commit;

               P_REFRESH( 'FAUTH_MVIEW', w_proc_rtncd );

               -- テーブル更新ログ書き込み
               insert into api20_tbl_updt_log
               values(sysdate, 'FMST','MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd,null);
               commit;

               -- API企業マスタ更新用メール送信
               fcorp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);

               if w_n_rtncd_mail <> 0 then
                 if w_n_rtncd_mail = 1 then
                    w_c_rtncd_mail := '0001';
                 else
                    w_c_rtncd_mail := '0009';
                 end if;
               else
                 w_c_rtncd_mail := '0000';
               end if;

               -- テーブル更新ログ書き込み
               insert into api20_tbl_updt_log
               values(sysdate,'FMST', 'MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
             end if;
             w_rtncd := '0000';

          else
             --レコードがなければ
             w_rtncd := '0004';
             o_rtncd := w_rtncd;
             insert into api20_tbl_updt_log
             values(sysdate,'FMST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, 'ユーザーID無しエラー（USERID:'||i_uid||')');
             commit;


          end if;
          close zdc_uid_cur;

        when 'U' then
          w_rtncd := '0001';
          o_rtncd := w_rtncd;
          insert into api20_tbl_updt_log
          values(sysdate, 'FMST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID無しエラー');
          commit;

        when 'D' then
          w_rtncd := '0001';
          o_rtncd := w_rtncd;
          insert into api20_tbl_updt_log
          values(sysdate, 'FMST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID無しエラー');
          commit;

        else
          w_rtncd := '0099';
        end case;

      end if;
      close api_corp_cur;

    end if;

  o_rtncd := 0;      -- 正常終了
  end if;

  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
    values(sysdate,'FMST',null, i_kbn, i_uid, i_cid, w_rtncd, '処理完了');
  commit;
  o_rtncd := w_rtncd;
  o_err_msg := null;

exception
  when others then
    rollback;
    w_rtncd    := '7001';
    w_msg      := substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'FMST',null, i_kbn, i_uid, i_cid, w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;

END p_corp_updt;


/*     API2.0リファラーテーブル更新プロシージ(無償版)   */
/*     変更日            担当        内容               */
/*     2014/05/09        細谷        新規作成           */
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
                                     --    '0002'：該当データ無しエラー
                                     --    '0003'：リファラー有りエラー
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
        from fapi20_referer_tbl
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
      from   fapi20_referer_tbl
      where  cid     = i_cid
      and    key_num = i_key_num
      for update;

  rf_rec             rf_cur%ROWTYPE;

  -- リファラーテーブルカーソル（登録時リファラー確認）
  CURSOR rf_unique(i_cid     in varchar2,
                   i_referer in varchar2) IS
      select cid,
             referer
      from   fapi20_referer_tbl
      where  cid     = i_cid
      and    referer = i_referer;

  rf_unique_rec             rf_unique%ROWTYPE;


  -- API企業マスタカーソル
  CURSOR api_corp_cur(i_cid in char) is
    select cid,
           s_date,
           e_date
    from fapi20_corp_mst
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
    open api_corp_cur(i_cid);    -- FAPI20_CORP_MSTに企業IDがあるかどうか
    fetch api_corp_cur into api_corp_rec;
    if api_corp_cur%FOUND then

      open rf_cur(i_cid,i_key_num);    -- FAPI20_REFERER_TBLにCIDとKEY_NUMがあるかどうか
      fetch rf_cur into rf_rec;
      if rf_cur%FOUND then             -- FAPI20_REFERER_TBLにCIDが該当する場合

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
                values(sysdate, 'FREFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, 'リファラー有りエラー');
                commit;

          when 'U' then
            -- APIキーテーブルデータ更新
            update fapi20_referer_tbl
              set referer      = i_referer,       -- 更新用リファラー
                  key_num      = i_key_num,       -- キー
                  service_name = i_service_name,  -- サービス名
                  upd_dt       = sysdate          -- 更新日（YYYYMMDDHHMMSS）
              where CURRENT OF rf_cur;
            w_rtncd := '0000';
            o_rtncd := w_rtncd;
            insert into api20_tbl_updt_log
            values(sysdate, 'FREFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
            commit;

            P_REFRESH( 'FAUTH_MVIEW', w_proc_rtncd );

            -- テーブル更新ログ書き込み
            insert into api20_tbl_updt_log
            values(sysdate, 'FREFERER','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
            commit;

          when 'D' then
               -- APIキーテーブルデータ削除
               delete from fapi20_referer_tbl
               where CURRENT OF rf_cur;
               commit;
            w_rtncd := '0000';
            o_rtncd := w_rtncd;
            insert into api20_tbl_updt_log
            values(sysdate, 'FREFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
            commit;

            P_REFRESH( 'FAUTH_MVIEW', w_proc_rtncd );

            -- テーブル更新ログ書き込み
            insert into api20_tbl_updt_log
            values(sysdate, 'FREFERER','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
            commit;

          else
            w_rtncd := '0099';
        end case;

      else   -- FAPI20_REFERER_TBLにCIDが該当しない場合

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
                  values(sysdate, 'FREFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, 'リファラー有りエラー');
                  commit;
              else

                  -- KEY_NUM自動発番（KEY_NUMがNULLの場合）
                  if i_key_num is null then
                      select nvl(max(key_num), 0) into i_key_num
                      from fapi20_referer_tbl
                      where cid = i_cid;
                      i_key_num := i_key_num + 1;
                  end if;

                  -- リファラーテーブルデータ追加
                  insert into fapi20_referer_tbl
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
                  values(sysdate, 'FREFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
                  commit;

                  P_REFRESH( 'FAUTH_MVIEW', w_proc_rtncd );

                  -- テーブル更新ログ書き込み
                  insert into api20_tbl_updt_log
                  values(sysdate, 'FREFERER','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                  commit;

              end if;
              close rf_unique;

          when 'U' then
              w_rtncd := '0002';
              o_rtncd := w_rtncd;
              insert into api20_tbl_updt_log
              values(sysdate, 'FREFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '該当データ無しエラー');
              commit;

          when 'D' then
              w_rtncd := '0002';
              o_rtncd := w_rtncd;
              insert into api20_tbl_updt_log
              values(sysdate, 'FREFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '該当データ無しエラー');
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
      values(sysdate, 'FREFERER','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '企業ID無しエラー');
      commit;

      o_rtncd := w_rtncd;

    end if;
    close api_corp_cur;

  end if;
  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
    values(sysdate,'FREFERER',null, i_kbn, i_uid, i_cid, w_rtncd, '処理完了');
  commit;
  o_rtncd := w_rtncd;
  o_err_msg := null;

EXCEPTION
  when others then
    rollback;
    w_rtncd    := '7001';
    w_msg      := substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'FREFERER',null, i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;

END p_referer_updt;



/*     API2.0仮登録テーブル更新プロシージャ       */
/*     変更日            担当        内容         */
/*     2014/05/09        細谷        新規作成     */
procedure p_proreg_updt (
  i_kbn          in     char,        -- 更新区分（S:検索、I:登録、D:削除）
  i_id           in out varchar2,    -- ID
  i_maddr        in out varchar2,    -- メールアドレス
  o_ins_dt       out    char,        -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out    char,        -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out    char,        -- リターンコード
                                     --  '0000'：正常終了
                                     --  '0001'：該当データ無しエラー
                                     --  '0002'：ID有りエラー
                                     --  '0003'：メールアドレス有りエラー
                                     --  '0099'：更新区分エラー
                                     --  '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
                                     --     id:xxxxx,maddr:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
) is


  -- 仮登録テーブルカーソル（検索時使用、部分一致）
  CURSOR api_proreg_partial_cur(i_id in varchar2,i_maddr in varchar2) is
      select id,
             maddr,
             to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
      from   fapi20_proreg_tbl
      where decode(i_id,         null, 1, instr(id,        i_id))          != 0
        and decode(i_maddr,      null, 1, instr(maddr,     i_maddr))       != 0
      for update;

  api_proreg_partial_rec        api_proreg_partial_cur%ROWTYPE;


  -- 仮登録テーブルカーソル(削除時使用、idの完全一致)
  CURSOR api_proreg_complete_cur(i_id in varchar2,i_maddr in varchar2) is
      select id,
             maddr,
             to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
      from   fapi20_proreg_tbl
      where id = i_id
      and decode(i_maddr,      null, 1, instr(maddr,     i_maddr))       != 0
      for update;

  api_proreg_complete_rec        api_proreg_complete_cur%ROWTYPE;


  -- 仮登録テーブルカーソル（ID確認、追加時使用）
  CURSOR id_cur(i_id in varchar2) IS
      select maddr
      from   fapi20_proreg_tbl
      where  id  = i_id;

  id_rec             id_cur%ROWTYPE;

  -- 仮登録テーブルカーソル（メアド確認、追加時使用）
  CURSOR maddr_cur(i_maddr in varchar2) IS
      select maddr
      from   fapi20_proreg_tbl
      where  maddr  = i_maddr;

  maddr_rec             maddr_cur%ROWTYPE;


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

  case i_kbn
    when 'S' then
      open api_proreg_partial_cur(i_id,i_maddr);
      fetch api_proreg_partial_cur into api_proreg_partial_rec;
      if api_proreg_partial_cur%FOUND then

        i_id            := api_proreg_partial_rec.id;           -- 企業ID
        i_maddr         := api_proreg_partial_rec.maddr;        -- キー
        o_ins_dt        := api_proreg_partial_rec.ins_dt;       -- 登録日（YYYYMMDDHHMMSS）
        o_upd_dt        := api_proreg_partial_rec.upd_dt;       -- 更新日（YYYYMMDDHHMMSS）

        w_cnt := w_cnt + 1;
        o_info(w_cnt) := 'id'         || ':"' || api_proreg_partial_rec.id           || '",' ||
                         'maddr'      || ':"' || api_proreg_partial_rec.maddr        || '",' ||
                         'ins_dt'     || ':"' || api_proreg_partial_rec.ins_dt       || '",' ||
                         'upd_dt'     || ':"' || api_proreg_partial_rec.upd_dt       || '"';
        o_cnt := 1;
        w_rtncd := '0000';
      else
        w_rtncd := '0001';
      end if;
      close api_proreg_partial_cur;

    when 'I' then
      open id_cur(i_id);
      fetch id_cur into id_rec;
      if id_cur%FOUND then
        w_rtncd := '0002';
        insert into api20_tbl_updt_log
        values(sysdate, 'PROREG','TABLE', i_kbn, '', i_id||' maddr:'||i_maddr, w_rtncd, 'ID有りエラー');
        commit;
      else
        open maddr_cur(i_maddr);
        fetch maddr_cur into maddr_rec;
        if maddr_cur%FOUND then
          w_rtncd := '0003';
          insert into api20_tbl_updt_log
          values(sysdate, 'PROREG','TABLE', i_kbn, '', i_id||' maddr:'||i_maddr, w_rtncd, 'メールアドレス有りエラー');
          commit;
        else
          -- 仮登録テーブルデータ追加
          insert into fapi20_proreg_tbl
          values(i_id,               -- ID
                 i_maddr,            -- メールアドレス
                 sysdate,            -- 登録日（YYYYMMDDHHMMSS）
                 sysdate             -- 更新日（YYYYMMDDHHMMSS）
          );
          commit;
          w_rtncd := '0000';
          insert into api20_tbl_updt_log
          values(sysdate, 'PROREG','TABLE', i_kbn, '', i_id||' maddr:'||i_maddr, w_rtncd, null);
          commit;

        end if;
        close maddr_cur;
      end if;
      close id_cur;

    when 'D' then
      open api_proreg_complete_cur(i_id,i_maddr);
      fetch api_proreg_complete_cur into api_proreg_complete_rec;
      if api_proreg_complete_cur%FOUND then
        delete from fapi20_proreg_tbl
        where current of api_proreg_complete_cur;
        commit;
        w_rtncd := '0000';
        insert into api20_tbl_updt_log
        values(sysdate, 'PROREG','TABLE', i_kbn, '', i_id||' maddr:'||i_maddr, w_rtncd, null);
        commit;
      else
        w_rtncd := '0001';
        insert into api20_tbl_updt_log
        values(sysdate, 'PROREG','TABLE', i_kbn, '', i_id||' maddr:'||i_maddr, w_rtncd, '該当データ無しエラー');
        commit;
      end if;
      close api_proreg_complete_cur;

    else
      w_rtncd := '0099';

  end case;
  o_rtncd := w_rtncd;
  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
  values(sysdate,'PROREG',null, i_kbn, '', i_id, w_rtncd, '処理完了');
  commit;
  o_rtncd := w_rtncd;
  o_err_msg := null;

EXCEPTION
  when others then
    rollback;
    w_rtncd    := '7001';
    w_msg      := substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'PROREG',null, i_kbn, '', i_id||' maddr:'||i_maddr, w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;

END p_proreg_updt;


/*     API20本登録(無償版→有償版)プロシージャ    */
/*     変更日            担当        内容         */
/*     2014/05/09        細谷        新規作成     */
/*     2015/06/18        加藤        insert api20_corp_mst 文にカラム名追加 */
procedure p_reg (
  i_uid          in     varchar2,    -- ユーザID
  i_cid          in     varchar2,    -- 企業ID
  o_rtncd        out    char,        -- リターンコード
                                     --  '0000'：正常終了
                                     --  '0001'：企業ID無しエラー
                                     --  '0002'：企業ID有りエラー
                                     --  '7001'：その他エラー
  o_err_msg      out    varchar2     -- エラーメッセージ
) is

  -- API企業情報取得カーソル(無償版)
  CURSOR fapi_corp_cur(i_cid in char)
  IS
    select  cid,
            passwd,
            cname,
            cname_kana,
            addr,
            post,
            tel,
            dept,
            s_date,
            e_date,
            sales_id,
            other_maddr,
            end_flg,
            usage||'::'||maddr||'::'||hack_flg||'::'||note||'::'||user_flg||'::'||known_trigger as usage,
            name
    from fapi20_corp_mst
    where cid = i_cid
    for update;

    fapi_corp_rec  fapi_corp_cur%ROWTYPE;

  -- API企業情報取得カーソル(有償版)
  CURSOR api_corp_cur(i_cid in char)
  IS
    select  cid
    from api20_corp_mst
    where cid = i_cid;

    api_corp_rec  api_corp_cur%ROWTYPE;


  -- ワーク変数
  w_n_rtncd_mail number;         -- リターンコード(企業マスタ更新用メール送信プロシージャ用)
  w_c_rtncd_mail char(4);        -- リターンコード(企業マスタ更新用メール送信プロシージャ用)
  w_rtncd        char(4);        -- リターンコード
  w_msg          varchar2(200);  -- エラーメッセージ
  w_proc_rtncd   char(4);        -- リターンコード

BEGIN
  -- クリア
  o_rtncd   := '0000';
  o_err_msg := null;

  w_rtncd   := '0000';

  open fapi_corp_cur(i_cid);
  fetch fapi_corp_cur into fapi_corp_rec;
  if fapi_corp_cur%FOUND then
    open api_corp_cur(i_cid);
    fetch api_corp_cur into api_corp_rec;
    if api_corp_cur%FOUND then
      w_rtncd := '0002';
      o_rtncd := w_rtncd;
      insert into api20_tbl_updt_log
      values(sysdate, 'REG','TABLE', 'I', i_uid, i_cid, w_rtncd, '企業ID有りエラー');
      commit;
    else
        -- API企業マスタ(無償版)からAPI企業マスタ(有償版)へコピー
        insert into api20_corp_mst
        (
            cid,                                                -- 企業ID
            passwd,                                             -- パスワード
            cname,                                              -- 企業名
            cname_kana,                                         -- 企業名カナ
            addr,                                               -- 住所
            post,                                               -- 郵便番号
            tel,                                                -- 電話番号
            dept,                                               -- 部署
            s_date,                                             -- サービス開始日付（YYYYMMDDHHMMSS）
            e_date,                                             -- サービス終了日付（YYYYMMDDHHMMSS）
            sales_id,                                           -- 担当営業ユーザID
            other_maddr,                                        -- メールアドレス
            end_flg,                                            -- 契約終了フラグ（0:利用中、1:終了）
            usage,                                              -- 用途(用途::メールアドレス::ハッカソン::備考::利用者フラグ::サイトを知ったきっかけ)
            ins_dt,                                             -- 登録日（YYYYMMDDHHMMSS）
            upd_dt,                                             -- 更新日（YYYYMMDDHHMMSS）
            name                                                -- 氏名
          )
          values(
            fapi_corp_rec.cid,                                  -- 企業ID
            fapi_corp_rec.passwd,                               -- パスワード
            fapi_corp_rec.cname,                                -- 企業名
            fapi_corp_rec.cname_kana,                           -- 企業名カナ
            fapi_corp_rec.addr,                                 -- 住所
            fapi_corp_rec.post,                                 -- 郵便番号
            fapi_corp_rec.tel,                                  -- 電話番号
            fapi_corp_rec.dept,                                 -- 部署
            fapi_corp_rec.s_date,                               -- サービス開始日付（YYYYMMDDHHMMSS）
            fapi_corp_rec.e_date,                               -- サービス終了日付（YYYYMMDDHHMMSS）
            fapi_corp_rec.sales_id,                             -- 担当営業ユーザID
            fapi_corp_rec.other_maddr,                          -- メールアドレス
            fapi_corp_rec.end_flg,                              -- 契約終了フラグ（0:利用中、1:終了）
            fapi_corp_rec.usage,                                -- 用途(用途::メールアドレス::ハッカソン::備考::利用者フラグ::サイトを知ったきっかけ)
            sysdate,                                            -- 登録日（YYYYMMDDHHMMSS）
            sysdate,                                            -- 更新日（YYYYMMDDHHMMSS）
            fapi_corp_rec.name                                  -- 氏名
          );

        insert into api20_tbl_updt_log
        values(sysdate, 'MST','TABLE', 'I', i_uid, i_cid, w_rtncd,null);
        commit;

        -- リファラーテーブル(無償版)からリファラーテーブル(有償版)へコピー
        insert into api20_referer_tbl
        select cid,key_num,referer,service_name,sysdate,sysdate from fapi20_referer_tbl
        where cid = i_cid;

        insert into api20_tbl_updt_log
        values(sysdate, 'REFERER','TABLE', 'I', i_uid, i_cid, w_rtncd,null);
        commit;

/*
        -- API企業マスタ(無償版)から削除
        delete from fapi20_corp_mst
        where current of fapi_corp_cur;
*/

        update fapi20_corp_mst
        set upd_dt = sysdate
        where current of fapi_corp_cur;

        insert into api20_tbl_updt_log
        values(sysdate, 'FMST','TABLE', 'U', i_uid, i_cid, w_rtncd,null);
        commit;

/*
        -- リファラーテーブル(無償版)から削除
        delete from fapi20_referer_tbl
        where cid = i_cid;
*/

        update fapi20_referer_tbl
        set upd_dt = sysdate
        where cid = i_cid;

        insert into api20_tbl_updt_log
        values(sysdate, 'FREFERER','TABLE', 'U', i_uid, i_cid, w_rtncd,null);
        commit;

        w_rtncd := '0000';
        o_rtncd := w_rtncd;

        P_REFRESH( 'FAUTH_MVIEW', w_proc_rtncd );

        -- テーブル更新ログ書き込み
        insert into api20_tbl_updt_log
        values(sysdate, 'FMST','MVIEW', 'I', i_uid, i_cid, w_proc_rtncd,null);
        commit;

        P_REFRESH( 'AUTH_MVIEW', w_proc_rtncd );

        -- テーブル更新ログ書き込み
        insert into api20_tbl_updt_log
        values(sysdate, 'MST','MVIEW', 'I', i_uid, i_cid, w_proc_rtncd,null);
        commit;

        -- API企業マスタ更新用メール送信
        corp_mst_update_mail(i_cid, 'I', i_uid, w_n_rtncd_mail);

        if w_n_rtncd_mail <> 0 then
          if w_n_rtncd_mail = 1 then
             w_c_rtncd_mail := '0001';
          else
             w_c_rtncd_mail := '0009';
          end if;
        else
          w_c_rtncd_mail := '0000';
        end if;

        -- テーブル更新ログ書き込み
        insert into api20_tbl_updt_log
        values(sysdate,'MST', 'MAIL', 'I', i_uid, i_cid, w_c_rtncd_mail, null);
        commit;

    end if;
    close api_corp_cur;

  else

    w_rtncd := '0001';
    o_rtncd := w_rtncd;
    insert into api20_tbl_updt_log
    values(sysdate, 'REG','TABLE', 'I', i_uid, i_cid, w_rtncd, '企業ID無しエラー');
    commit;

  end if;
  close fapi_corp_cur;

  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
  values(sysdate,'REG',null, 'I', i_uid, i_cid, w_rtncd, '処理完了');
  commit;
  o_rtncd := w_rtncd;
  o_err_msg := null;

EXCEPTION
  when others then
    rollback;
    w_rtncd    := '7001';
    w_msg      := substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'REG',null, 'I', i_uid, i_cid, w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;
END p_reg;



/*     API2.0パスワード忘れ確認情報更新プロシージャ       */
/*     変更日            担当        内容                 */
/*     2014/08/29        川本        新規作成             */
procedure p_pwdcfm_updt (
  i_kbn          in     char,        -- 更新区分（S:検索、I:登録、D:削除）
  i_id           in out varchar2,    -- ID
  i_cid          in out varchar2,    -- 企業ID
  o_ins_dt       out    char,        -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out    char,        -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out    char,        -- リターンコード
                                     --  '0000'：正常終了
                                     --  '0001'：該当データ無しエラー
                                     --  '0002'：ID有りエラー
                                     --  '0003'：メールアドレス有りエラー
                                     --  '0099'：更新区分エラー
                                     --  '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
                                     --     id:xxxxx,cid:xxxxx,ins_dt:yyyymmddhh24miss,upd_dt:yyyymmddhh24miss
) is


  -- パスワード忘れ確認テーブルカーソル（検索時使用）
  CURSOR api_pwdcfm_partial_cur(i_id in varchar2,i_cid in varchar2) is
      select id,
             cid,
             to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
      from   fapi20_pwdcfm_tbl
      where decode(i_id,       null, 1, instr(id,      i_id))        != 0
        and decode(i_cid,      null, 1, instr(cid,     i_cid))       != 0
      for update;

  api_pwdcfm_partial_rec        api_pwdcfm_partial_cur%ROWTYPE;

  -- パスワード忘れ確認テーブルカーソル(削除時使用)
  CURSOR api_pwdcfm_complete_cur(i_id in varchar2,i_cid in varchar2) is
      select id,
             cid,
             to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
      from   fapi20_pwdcfm_tbl
      where id = i_id
      and decode(i_cid,      null, 1, instr(cid,     i_cid))       != 0
      for update;

  api_pwdcfm_complete_rec        api_pwdcfm_complete_cur%ROWTYPE;


  -- パスワード忘れ確認テーブルカーソル（ID確認、追加時使用）
  CURSOR id_cur(i_id in varchar2) IS
      select cid
      from   fapi20_pwdcfm_tbl
      where  id  = i_id;

  id_rec             id_cur%ROWTYPE;

  -- パスワード忘れ確認テーブルカーソル（メアド確認、追加時使用）
  CURSOR cid_cur(i_cid in varchar2) IS
      select cid
      from   fapi20_pwdcfm_tbl
      where  cid  = i_cid;

  cid_rec             cid_cur%ROWTYPE;



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

  case i_kbn
    when 'S' then
      open api_pwdcfm_partial_cur(i_id,i_cid);
      fetch api_pwdcfm_partial_cur into api_pwdcfm_partial_rec;
      if api_pwdcfm_partial_cur%FOUND then

        i_id            := api_pwdcfm_partial_rec.id;           -- ID
        i_cid           := api_pwdcfm_partial_rec.cid;          -- 企業ID
        o_ins_dt        := api_pwdcfm_partial_rec.ins_dt;       -- 登録日（YYYYMMDDHHMMSS）
        o_upd_dt        := api_pwdcfm_partial_rec.upd_dt;       -- 更新日（YYYYMMDDHHMMSS）

        w_cnt := w_cnt + 1;
        o_info(w_cnt) := 'id'         || ':"' || api_pwdcfm_partial_rec.id           || '",' ||
                         'cid'        || ':"' || api_pwdcfm_partial_rec.cid          || '",' ||
                         'ins_dt'     || ':"' || api_pwdcfm_partial_rec.ins_dt       || '",' ||
                         'upd_dt'     || ':"' || api_pwdcfm_partial_rec.upd_dt       || '"';
        o_cnt := 1;
        w_rtncd := '0000';
      else
        w_rtncd := '0001';
      end if;
      close api_pwdcfm_partial_cur;

    when 'I' then
      open id_cur(i_id);
      fetch id_cur into id_rec;
      if id_cur%FOUND then
        w_rtncd := '0002';
        insert into api20_tbl_updt_log
        values(sysdate, 'PWDCFM','TABLE', i_kbn, '', i_id||' cid:'||i_cid, w_rtncd, 'ID有りエラー');
        commit;
      else
        open cid_cur(i_cid);
        fetch cid_cur into cid_rec;
        if cid_cur%FOUND then
          w_rtncd := '0003';
          insert into api20_tbl_updt_log
          values(sysdate, 'PWDCFM','TABLE', i_kbn, '', i_id||' cid:'||i_cid, w_rtncd, '企業ID有りエラー');
          commit;
        else
          -- パスワード忘れ確認テーブルデータ追加
          insert into fapi20_pwdcfm_tbl
          values(i_id,               -- ID
                 i_cid,              -- 企業ID
                 sysdate,            -- 登録日（YYYYMMDDHHMMSS）
                 sysdate             -- 更新日（YYYYMMDDHHMMSS）
          );
          commit;
          w_rtncd := '0000';
          insert into api20_tbl_updt_log
          values(sysdate, 'PWDCFM','TABLE', i_kbn, '', i_id||' cid:'||i_cid, w_rtncd, null);
          commit;

        end if;
        close cid_cur;
      end if;
      close id_cur;

    when 'D' then
      open api_pwdcfm_complete_cur(i_id,i_cid);
      fetch api_pwdcfm_complete_cur into api_pwdcfm_complete_rec;
      if api_pwdcfm_complete_cur%FOUND then
        delete from fapi20_pwdcfm_tbl
        where current of api_pwdcfm_complete_cur;
        commit;
        w_rtncd := '0000';
        insert into api20_tbl_updt_log
        values(sysdate, 'PWDCFM','TABLE', i_kbn, '', i_id||' cid:'||i_cid, w_rtncd, null);
        commit;
      else
        w_rtncd := '0001';
        insert into api20_tbl_updt_log
        values(sysdate, 'PWDCFM','TABLE', i_kbn, '', i_id||' cid:'||i_cid, w_rtncd, '該当データ無しエラー');
        commit;
      end if;
      close api_pwdcfm_complete_cur;

    else
      w_rtncd := '0099';

  end case;
  o_rtncd := w_rtncd;
  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
  values(sysdate,'PWDCFM',null, i_kbn, '', i_id, w_rtncd, '処理完了');
  commit;
  o_rtncd := w_rtncd;
  o_err_msg := null;

EXCEPTION
  when others then
    rollback;
    w_rtncd    := '7001';
    w_msg      := substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'PWDCFM',null, i_kbn, '', i_id||' cid:'||i_cid, w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;

END p_pwdcfm_updt;

END p_fapi20_pkg;