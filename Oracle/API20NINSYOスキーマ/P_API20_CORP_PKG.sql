CREATE OR REPLACE PACKAGE "API20NINSYO".p_api20_corp_pkg AS

-- 変数定義
TYPE tbl_type IS TABLE OF varchar2(4000)
        INDEX BY BINARY_INTEGER;    -- 配列変数タイプ

/*     API2.0企業マスタ更新プロシージャ                                            */
/*     変更日            担当        内容                                          */
/*     2011/03/23        蛯澤        新規作成                                      */
/*     2011/06/15        蛯澤        パラメータ追加(i_passwd)                      */
/*     2011/07/28        蛯澤        パラメータ追加(i_addr,i_post,i_tel,i_usage)   */
/*     2014/09/03        川本        パラメータ追加(i_name)                        */
/*     2015/06/18        加藤        insert api20_corp_mst 文にカラム名追加        */
/*     2015/06/18        加藤        API20_CORP_MSTカラム追加 (VERSION,RPRT_FLG)   */
/*                                   パラメータ追加 (i_version,i_rprt_flg)         */
procedure p_corp_updt (
  i_kbn          in      char,      -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid          in      varchar2,  -- ユーザID
  i_cid          in out  varchar2,  -- 企業ID
  i_passwd       in out  varchar2,  -- パスワード
  i_cname        in out  varchar2,  -- 企業名
  i_cname_kana   in out  varchar2,  -- 企業名カナ
  i_addr         in out  varchar2,  -- 住所
  i_post         in out  varchar2,  -- 郵便番号
  i_tel          in out  varchar2,  -- 電話番号
  i_dept         in out  varchar2,  -- 部署名
  i_s_date       in out  varchar2,  -- サービス開始日付（YYYYMMDDHHMMSS）
  i_e_date       in out  varchar2,  -- サービス終了日付（YYYYMMDDHHMMSS）
  i_s_date_op    in      varchar2,  -- 開始日付検索条件（1:以前、2:一致、3:以降）
  i_e_date_op    in      varchar2,  -- 終了日付検索条件（1:以前、2:一致、3:以降）
  i_sales_id     in out  varchar2,  -- 担当営業ユーザID
  i_other_maddr  in out  varchar2,  -- 関係者メールアドレス
  i_end_flg      in out  varchar2,  -- 契約終了フラグ（0:利用中(デフォルト、1:終了)）
  i_usage        in out  varchar2,  -- 用途
  i_name         in out  varchar2,  -- 氏名
  i_version      in out  varchar2,  -- APIバージョン
  i_rprt_flg     in out  varchar2,  -- ログレポート閲覧許可フラグ(0:不可,1:可)
  i_pos          in      number,    -- 取得位置（複数検索時指定）
  i_cnt          in      number,    -- 取得件数（複数検索時指定）
  o_ins_dt       out     char,      -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out     char,      -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out     char,      -- リターンコード
                                    --  '0000'：正常終了
                                    --  '0001'：企業ID無しエラー
                                    --  '0002'：企業ID有りエラー
                                    --  '0004'：ユーザID無しエラー
                                    --  '0099'：更新区分エラー
                                    --  '7001'：その他エラー
  o_err_msg      out     varchar2,  -- エラーメッセージ
  o_cnt          out     number,    -- 全データ件数
  o_info         out     tbl_type   -- 複数件返却情報（キー:バリュー形式）
);

END p_api20_corp_pkg;
/


CREATE OR REPLACE PACKAGE BODY "API20NINSYO".p_api20_corp_pkg AS

/*********************************************************************************/
/*                                                                               */
/*     API2.0企業マスタ更新プロシージャ                                          */
/*                                                                               */
/*     変更日            担当        内容                                        */
/*     2011/04/15        蛯澤        新規作成                                    */
/*     2011/06/15        蛯澤        パラメータ追加(i_passwd)                    */
/*     2011/06/23        蛯澤        返却項目追加(usermei)                       */
/*     2011/07/28        蛯澤        パラメータ・返却項目追加                    */
/*                                   (i_addr,i_post,i_tel,i_usage)               */
/*     2011/10/12        細谷        契約終了フラグによる終了日操作を廃止        */
/*     2014/04/21        細谷        AUTH_NOREF_MVIEWのREFRESH追加               */
/*     2014/07/29        細谷        api_corp_searchのorderby句変更              */
/*     2014/07/30        細谷        api_corp_searchの結合条件変更               */
/*     2014/09/03        川本        パラメータ・返却項目追加(i_name)            */
/*                                                                               */
/*********************************************************************************/
PROCEDURE p_corp_updt (
  i_kbn          in      char,      -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid          in      varchar2,  -- ユーザID
  i_cid          in out  varchar2,  -- 企業ID
  i_passwd       in out  varchar2,  -- パスワード
  i_cname        in out  varchar2,  -- 企業名
  i_cname_kana   in out  varchar2,  -- 企業名カナ
  i_addr         in out  varchar2,  -- 住所
  i_post         in out  varchar2,  -- 郵便番号
  i_tel          in out  varchar2,  -- 電話番号
  i_dept         in out  varchar2,  -- 部署名
  i_s_date       in out  varchar2,  -- サービス開始日付（YYYYMMDDHHMMSS）
  i_e_date       in out  varchar2,  -- サービス終了日付（YYYYMMDDHHMMSS）
  i_s_date_op    in      varchar2,  -- 開始日付検索条件（1:以前、2:一致、3:以降）
  i_e_date_op    in      varchar2,  -- 終了日付検索条件（1:以前、2:一致、3:以降）
  i_sales_id     in out  varchar2,  -- 担当営業ユーザID
  i_other_maddr  in out  varchar2,  -- 関係者メールアドレス
  i_end_flg      in out  varchar2,  -- 契約終了フラグ（0:利用中(デフォルト、1:終了)）
  i_usage        in out  varchar2,  -- 用途
  i_name         in out  varchar2,  -- 氏名
  i_version      in out  varchar2,  -- APIバージョン
  i_rprt_flg     in out  varchar2,  -- ログレポート閲覧許可フラグ(0:不可,1:可)
  i_pos          in      number,    -- 取得位置（複数検索時指定）
  i_cnt          in      number,    -- 取得件数（複数検索時指定）
  o_ins_dt       out     char,      -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out     char,      -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out     char,      -- リターンコード
                                    --  '0000'：正常終了
                                    --  '0002'：企業ID有りエラー
                                    --  '0004'：ユーザID無しエラー
                                    --  '0099'：更新区分エラー
                                    --  '7001'：その他エラー
  o_err_msg      out     varchar2,  -- エラーメッセージ
  o_cnt          out     number,    -- 全データ件数
  o_info         out     tbl_type   -- 複数件返却情報（キー:バリュー形式）
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
                         i_name          in  varchar2,
                         i_version       in  varchar2,
                         i_rprt_flg      in  varchar2,
                         i_pos           in  number,
                         i_cnt           in  number)
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
               a.name,
               a.version,
               a.rprt_flg,
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
                     name,
                     version,
                     rprt_flg,
                     ins_dt,
                     upd_dt,
                     count(*) over () all_cnt
                     FROM api20_corp_mst
                     WHERE DECODE(i_cid,          null, 1, instr(cid,        ltrim(i_cid, '*')))  != 0
                       AND DECODE(i_passwd,       null, 1, instr(passwd,     i_passwd))           != 0
                       AND DECODE(i_cname,        null, 1, instr(cname,      i_cname))            != 0
                       AND DECODE(i_cname_kana,   null, 1, instr(cname_kana, i_cname_kana))       != 0
                       AND DECODE(i_addr,         null, 1, instr(addr,       i_addr))             != 0
                       AND DECODE(i_post,         null, 1, instr(post,       i_post))             != 0
                       AND DECODE(i_tel,          null, 1, instr(tel,        i_tel))              != 0
                       AND DECODE(i_dept,         null, 1, instr(dept,       i_dept))             != 0
                       AND DECODE(i_sales_id,     null, 1, instr(sales_id,   i_sales_id))         != 0
                       AND DECODE(i_other_maddr,  null, 1, instr(other_maddr,i_other_maddr))      != 0
                       AND DECODE(i_end_flg,      null, 1, instr(end_flg,    i_end_flg))          != 0
                       AND DECODE(i_usage,        null, 1, instr(usage,      i_usage))            != 0
                       AND DECODE(i_name,         null, 1, instr(name,       i_name))             != 0
                       AND DECODE(i_version,      null, 1, instr(version,    i_version))          != 0
                       AND DECODE(i_rprt_flg,     null, 1, instr(rprt_flg,   i_rprt_flg))         != 0
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
            name,
            version,
            rprt_flg,
            to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
            to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
    from api20_corp_mst
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
                                                   i_name,
                                                   i_version,
                                                   i_rprt_flg,
                                                   i_pos,
                                                   i_cnt)
        LOOP
        w_cnt := w_cnt + 1;
        o_info(w_cnt) := 'cid'          || ':"' || api_corp_search_rec.cid          || '",' ||
                         'passwd'       || ':"' || api_corp_search_rec.passwd       || '",' ||
                         'cname'        || ':"' || api_corp_search_rec.cname        || '",' ||
                         'cname_kana'   || ':"' || api_corp_search_rec.cname_kana   || '",' ||
                         'addr'         || ':"' || api_corp_search_rec.addr         || '",' ||
                         'post'         || ':"' || api_corp_search_rec.post         || '",' ||
                         'tel '         || ':"' || api_corp_search_rec.tel          || '",' ||
                         'dept'         || ':"' || api_corp_search_rec.dept         || '",' ||
                         's_date'       || ':"' || api_corp_search_rec.s_date       || '",' ||
                         'e_date'       || ':"' || api_corp_search_rec.e_date       || '",' ||
                         'sales_id'     || ':"' || api_corp_search_rec.sales_id     || '",' ||
                         'usermei'      || ':"' || api_corp_search_rec.usermei      || '",' ||
                         'other_maddr'  || ':"' || api_corp_search_rec.other_maddr  || '",' ||
                         'end_flg'      || ':"' || api_corp_search_rec.end_flg      || '",' ||
                         'usage'        || ':"' || api_corp_search_rec.usage        || '",' ||
                         'name'         || ':"' || api_corp_search_rec.name         || '",' ||
                         'version'      || ':"' || api_corp_search_rec.version      || '",' ||
                         'rprt_flg'     || ':"' || api_corp_search_rec.rprt_flg     || '",' ||
                         'ins_dt'       || ':"' || api_corp_search_rec.ins_dt       || '",' ||
                         'upd_dt'       || ':"' || api_corp_search_rec.upd_dt       || '"';

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
             i_name          := null;
             i_version       := null;
             i_rprt_flg      := null;
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
                      i_name          := api_corp_rec.name;
                      i_version       := api_corp_rec.version;
                      i_rprt_flg      := api_corp_rec.rprt_flg;
                      o_ins_dt        := api_corp_rec.ins_dt;
                      o_upd_dt        := api_corp_rec.upd_dt;

                      OPEN zdc_uid_cur(i_sales_id);      -- DBリンク越しに見ているテーブルを含めたSELECT ～FOR UPDATEは出来ないので、USERMEI表示はカーソルで制御
                      fetch zdc_uid_cur into zdc_uid_rec;
                      w_usermei := zdc_uid_rec.usermei;
                          w_cnt := w_cnt + 1;
                          o_info(w_cnt) := 'cid'          || ':"' || api_corp_rec.cid          || '",' ||
                                           'passwd'       || ':"' || api_corp_rec.passwd       || '",' ||
                                           'cname'        || ':"' || api_corp_rec.cname        || '",' ||
                                           'cname_kana'   || ':"' || api_corp_rec.cname_kana   || '",' ||
                                           'addr'         || ':"' || api_corp_rec.addr         || '",' ||
                                           'post'         || ':"' || api_corp_rec.post         || '",' ||
                                           'tel'          || ':"' || api_corp_rec.tel          || '",' ||
                                           'dept'         || ':"' || api_corp_rec.dept         || '",' ||
                                           's_date'       || ':"' || api_corp_rec.s_date       || '",' ||
                                           'e_date'       || ':"' || api_corp_rec.e_date       || '",' ||
                                           'sales_id'     || ':"' || api_corp_rec.sales_id     || '",' ||
                                           'usermei'      || ':"' || w_usermei                 || '",' ||
                                           'other_maddr'  || ':"' || api_corp_rec.other_maddr  || '",' ||
                                           'end_flg'      || ':"' || api_corp_rec.end_flg      || '",' ||
                                           'usage'        || ':"' || api_corp_rec.usage        || '",' ||
                                           'name'         || ':"' || api_corp_rec.name         || '",' ||
                                           'version'      || ':"' || api_corp_rec.version      || '",' ||
                                           'rprt_flg'     || ':"' || api_corp_rec.rprt_flg     || '",' ||
                                           'ins_dt'       || ':"' || api_corp_rec.ins_dt       || '",' ||
                                           'upd_dt'       || ':"' || api_corp_rec.upd_dt       || '"';
                          o_cnt := 1;
                          o_rtncd := '0000';

                      close zdc_uid_cur;


                when 'I' then
                      w_rtncd := '0002';
                      o_rtncd := w_rtncd;
                      -- テーブル更新ログ書き込み
                      insert into api20_tbl_updt_log
                      values(sysdate,'MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID有りエラー');
                      commit;

                when 'U' then
                      open zdc_uid_cur(i_sales_id);
                      fetch zdc_uid_cur into zdc_uid_rec;
                      if zdc_uid_cur%FOUND then

                          -- API企業マスタデータ更新
                          update api20_corp_mst
                            set
                              cid          = i_cid,                                   -- 企業ID
                              passwd       = i_passwd,                                -- パスワード
                              cname        = i_cname,                                 -- 企業名
                              cname_kana   = i_cname_kana,                            -- 企業名カナ
                              addr         = i_addr,                                  -- 住所
                              post         = i_post,                                  -- 郵便番号
                              tel          = i_tel,                                   -- 電話番号
                              dept         = i_dept,                                  -- 部署
                              s_date       = to_date(i_s_date, 'yyyymmddhh24miss'),   -- サービス開始日付（YYYYMMDDHHMMSS）
                              e_date       = to_date(i_e_date, 'yyyymmddhh24miss'),   -- サービス終了日付（YYYYMMDDHHMMSS）
                              sales_id     = i_sales_id,                              -- 担当営業ユーザID
                              other_maddr  = i_other_maddr,                           -- メールアドレス
                              end_flg      = nvl(i_end_flg,'0'),                      -- 契約終了フラグ（0:利用中、1:終了）
                              usage        = i_usage,                                 -- 用途
                              name         = i_name,                                  -- 氏名
                              version      = i_version,                               -- APIバージョン
                              rprt_flg     = nvl(i_rprt_flg,'0'),                     -- ログレポート閲覧許可フラグ(0:不可,1:可)
                              upd_dt       = sysdate                                  -- 更新日（YYYYMMDDHHMMSS）
                            where CURRENT OF api_corp_cur;
                            commit;

                            w_rtncd := '0000';
                            o_rtncd := w_rtncd;

                                -- テーブル更新ログ書き込み
                                insert into api20_tbl_updt_log
                                values(sysdate,'MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, null);
                                commit;

                                P_REFRESH( 'AUTH_MVIEW', w_proc_rtncd );

                                -- テーブル更新ログ書き込み
                                insert into api20_tbl_updt_log
                                values(sysdate,'MST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
                                commit;

                                P_REFRESH( 'AUTH_NOREF_MVIEW', w_proc_rtncd );

                                -- テーブル更新ログ書き込み
                                insert into api20_tbl_updt_log
                                values(sysdate,'MST', 'NOREF', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
                                commit;

                                -- API企業マスタ更新用メール送信
                                corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);

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
                                   values(sysdate, 'MST','MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
                                   commit;

                      else
                          w_rtncd := '0004';
                          o_rtncd := w_rtncd;
                          -- テーブル更新ログ書き込み
                          insert into api20_tbl_updt_log
                          values(sysdate, 'MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, 'ユーザーID無しエラー（USERID:'||i_uid||')');
                          commit;

                      end if;

                      close zdc_uid_cur;

                when 'D' then
                      -- API企業マスタデータ削除
                      -- API企業マスタ更新用メール送信
                      corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);

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
                        values(sysdate,'MST', 'MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
                        commit;

                      delete from api20_corp_mst
                      where CURRENT OF api_corp_cur;

                      --同じ企業IDのリファラーも同時に削除
                      delete from api20_referer_tbl
                      where cid = i_cid;

                      w_rtncd := '0000';
                      o_rtncd := w_rtncd;

                          -- テーブル更新ログ書き込み
                          insert into api20_tbl_updt_log
                          values(sysdate, 'MST','TABLE', i_kbn, i_uid, i_cid, w_rtncd,null);
                          commit;

                          P_REFRESH( 'AUTH_MVIEW', w_proc_rtncd );

                          -- テーブル更新ログ書き込み
                          insert into api20_tbl_updt_log
                          values(sysdate, 'MST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
                          commit;

                          P_REFRESH( 'AUTH_NOREF_MVIEW', w_proc_rtncd );

                          -- テーブル更新ログ書き込み
                          insert into api20_tbl_updt_log
                          values(sysdate,'MST', 'NOREF', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
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
                         insert into api20_corp_mst
                          (
                            cid,                                     -- 企業ID
                            passwd,                                  -- パスワード
                            cname,                                   -- 企業名
                            cname_kana,                              -- 企業名カナ
                            addr,                                    -- 住所
                            post,                                    -- 郵便番号
                            tel,                                     -- 電話番号
                            dept,                                    -- 部署
                            s_date,                                  -- サービス開始日付（YYYYMMDDHHMMSS）
                            e_date,                                  -- サービス終了日付（YYYYMMDDHHMMSS）
                            sales_id,                                -- 担当営業ユーザID
                            other_maddr,                             -- メールアドレス
                            end_flg,                                 -- 契約終了フラグ（0:利用中、1:終了）
                            usage,                                   -- 用途(用途::メールアドレス::ハッカソン::備考::利用者フラグ::サイトを知ったきっかけ)
                            ins_dt,                                  -- 登録日（YYYYMMDDHHMMSS）
                            upd_dt,                                  -- 更新日（YYYYMMDDHHMMSS）
                            name,                                    -- 氏名
                            version,                                 -- APIバージョン
                            rprt_flg                                 -- ログレポート閲覧許可フラグ(0:不可,1:可)
                          )
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
                             sysdate,                                -- 登録日（YYYYMMDDHHMMSS）
                             sysdate,                                -- 更新日（YYYYMMDDHHMMSS）
                             i_name,                                 -- 氏名
                             i_version,                              -- APIバージョン
                             nvl(i_rprt_flg,'0')                     -- ログレポート閲覧許可フラグ(0:不可,1:可)
                           );
                         commit;
                               w_rtncd := '0000';
                               o_rtncd := w_rtncd;

                               if w_rtncd = '0000' then
                                   -- テーブル更新ログ書き込み
                                   insert into api20_tbl_updt_log
                                   values(sysdate, 'MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd,null);
                                   commit;

                                   P_REFRESH( 'AUTH_MVIEW', w_proc_rtncd );

                                   -- テーブル更新ログ書き込み
                                   insert into api20_tbl_updt_log
                                   values(sysdate, 'MST','MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd,null);
                                   commit;

                                   P_REFRESH( 'AUTH_NOREF_MVIEW', w_proc_rtncd );

                                   -- テーブル更新ログ書き込み
                                   insert into api20_tbl_updt_log
                                   values(sysdate,'MST', 'NOREF', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
                                   commit;

                                   -- API企業マスタ更新用メール送信
                                   corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);

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
                                   values(sysdate,'MST', 'MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
                              end if;
                               w_rtncd := '0000';

                      else
                         --レコードがなければ
                         w_rtncd := '0004';
                         o_rtncd := w_rtncd;
                         insert into api20_tbl_updt_log
                         values(sysdate,'MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, 'ユーザーID無しエラー（USERID:'||i_uid||')');
                         commit;


                      end if;
                      close zdc_uid_cur;

                when 'U' then
                    w_rtncd := '0001';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID無しエラー');
                    commit;

                when 'D' then
                dbms_output.put_line('TEST2');
                    w_rtncd := '0001';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID無しエラー');
                    commit;

                else
                    w_rtncd := '0099';
                end case;

            close api_corp_cur;
       end if;

     end if;

    o_rtncd := 0;      -- 正常終了
    END IF;


  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
    values(sysdate,'MST',null, i_kbn, i_uid, i_cid, w_rtncd, '処理完了');
  commit;
  o_rtncd := w_rtncd;
  o_err_msg := null;

exception
  when others then
    rollback;
    w_rtncd    := '7001';
    w_msg          := substrb(SQLERRM,1,200);

    -- テーブル更新ログ書き込み
    insert into api20_tbl_updt_log
      values(sysdate, 'MST',null, i_kbn, i_uid, i_cid, w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;

  END p_corp_updt;
END p_api20_corp_pkg;