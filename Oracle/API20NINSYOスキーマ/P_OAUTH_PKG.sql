CREATE OR REPLACE PACKAGE "API20NINSYO".p_oauth_pkg AS

-- 変数定義
TYPE tbl_type IS TABLE OF varchar2(4000)
        INDEX BY BINARY_INTEGER;    -- 配列変数タイプ

/*     端末認証 企業マスタ更新プロシージャ        */
/*     変更日            担当        内容         */
/*     2012/11/29        蛯澤        新規作成     */
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


/*     端末認証 秘密鍵テーブル更新プロシージャ    */
/*     変更日            担当        内容         */
/*     2012/11/29        蛯澤        新規作成     */
procedure p_key_updt (
  i_kbn          in     char,        -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid          in     varchar2,    -- ユーザID
  i_cid          in out varchar2,    -- 企業ID
  i_key_num      in out number,      -- キー番号
  i_consumer_id  in out varchar2,    -- クライアントID
  i_service_name in out varchar2,    -- サービス名
  i_key          in out varchar2,    -- 秘密鍵
  i_pos          in     number,      -- 取得位置（複数検索時指定）
  i_cnt          in     number,      -- 取得件数（複数検索時指定）
  o_ins_dt       out    char,        -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out    char,        -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out    char,        -- リターンコード
                                     --    '0000'：正常終了
                                     --    '0001'：企業ID無しエラー
                                     --    '0002'：該当データ無しエラー
                                     --    '0003'：クライアントID有りエラー
                                     --    '0004'：ユーザーID無しエラー
                                     --    '0099'：更新区分エラー
                                     --    '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
);

/*     端末認証 補足テーブル更新プロシージャ      */
/*     変更日            担当        内容         */
/*     2012/11/29        蛯澤        新規作成     */
procedure p_hosoku_tbl_updt (
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
);

END p_oauth_pkg;
/


CREATE OR REPLACE PACKAGE BODY "API20NINSYO".p_oauth_pkg AS

/*     端末認証 企業マスタ更新プロシージャ        */
/*     変更日            担当        内容         */
/*     2012/11/29        蛯澤        新規作成     */
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
  i_pos          in      number,    -- 取得位置（複数検索時指定）
  i_cnt          in      number,    -- 取得件数（複数検索時指定）
  o_ins_dt       out     char,      -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out     char,      -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out     char,      -- リターンコード
                                    --  '0000'：正常終了
                                    --  '0001'：企業ID無しエラー
                                    --  '0002'：企業ID有りエラー
                                    --  '0004'：担当者ID無しエラー
                                    --  '0099'：更新区分エラー
                                    --  '7001'：その他エラー
  o_err_msg      out     varchar2,  -- エラーメッセージ
  o_cnt          out     number,    -- 全データ件数
  o_info         out     tbl_type   -- 複数件返却情報（キー:バリュー形式）
) IS

  -- 企業情報取得カーソル（複数件検索用）
  CURSOR oauth_corp_search_cur(i_cid           in  varchar2,
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
                     ins_dt,
                     upd_dt,
                     count(*) over () all_cnt
                     FROM oauth_corp_mst
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
                     ) a , zdc_uid z where a.sales_id = z.userid
    )
    WHERE rnum between i_pos and (i_pos + i_cnt -1)
    ORDER BY e_date asc,cid asc;
--    ORDER BY rnum;

  -- 企業情報取得カーソル
  CURSOR oauth_corp_cur(i_cid in char)
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
            to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
            to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
    from oauth_corp_mst
    where cid = i_cid
    for update;

    oauth_corp_rec  oauth_corp_cur%ROWTYPE;

  -- ユーザマスタカーソル
  CURSOR zdc_uid_cur(i_sales_id in char)
  IS
    select userid,usermei
    from zdc_uid
    where userid = i_sales_id;

  zdc_uid_rec  zdc_uid_cur%ROWTYPE;

  -- ワーク変数
  w_msg          varchar2(200);   -- エラーメッセージ
  w_usermei      varchar2(40);    -- ユーザー名
  w_n_rtncd_mail number;          -- リターンコード(企業マスタ更新用メール送信プロシージャ用)
  w_c_rtncd_mail char(4);         -- リターンコード(企業マスタ更新用メール送信プロシージャ用)
  w_cnt          pls_integer;     -- 取得データ件数
  w_proc_rtncd   char(4);         -- リターンコード
  w_rtncd        char(4);         -- リターンコード



  BEGIN
    -- うるう年補正（2/29 -> 2/28）
    if substr(i_s_date,5,4) = '0229' then
        i_s_date := substr(i_s_date,1,4) || '0228' || substr(i_s_date,9);
    end if;

    -- 初期化
    o_rtncd   := '0000';
    w_rtncd   := '0000';
    w_usermei := null;
    o_err_msg := null;
    o_cnt     := 0;
    w_cnt     := 0;

    --CIDの指定がない時->複数件抽出
    if i_kbn = 'S' and (i_cid is null or substr(i_cid, 1, 1) = '*') then
        FOR oauth_corp_search_rec in oauth_corp_search_cur(i_cid,
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
                                                            i_pos,
                                                            i_cnt)
         LOOP
         w_cnt := w_cnt + 1;
         o_info(w_cnt) := 'cid'          || ':"' || oauth_corp_search_rec.cid          || '",' ||
                          'passwd'       || ':"' || oauth_corp_search_rec.passwd       || '",' ||
                          'cname'        || ':"' || oauth_corp_search_rec.cname        || '",' ||
                          'cname_kana'   || ':"' || oauth_corp_search_rec.cname_kana   || '",' ||
                          'addr'         || ':"' || oauth_corp_search_rec.addr         || '",' ||
                          'post'         || ':"' || oauth_corp_search_rec.post         || '",' ||
                          'tel'          || ':"' || oauth_corp_search_rec.tel          || '",' ||
                          'dept'         || ':"' || oauth_corp_search_rec.dept         || '",' ||
                          's_date'       || ':"' || oauth_corp_search_rec.s_date       || '",' ||
                          'e_date'       || ':"' || oauth_corp_search_rec.e_date       || '",' ||
                          'sales_id'     || ':"' || oauth_corp_search_rec.sales_id     || '",' ||
                          'usermei'      || ':"' || oauth_corp_search_rec.usermei      || '",' ||
                          'other_maddr'  || ':"' || oauth_corp_search_rec.other_maddr  || '",' ||
                          'end_flg'      || ':"' || oauth_corp_search_rec.end_flg      || '",' ||
                          'usage'        || ':"' || oauth_corp_search_rec.usage        || '",' ||
                          'ins_dt'       || ':"' || oauth_corp_search_rec.ins_dt       || '",' ||
                          'upd_dt'       || ':"' || oauth_corp_search_rec.upd_dt       || '"';

         o_cnt := oauth_corp_search_rec.all_cnt;
         END LOOP;

         o_rtncd   := '0000';
    else
        -- CIDを指定している場合->1件を抽出
        -- CID指定時のPOS=1以外指定チェック
        if i_kbn ='S' and i_pos != 1 then
             w_rtncd := '0000';
             o_rtncd := w_rtncd;
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
               o_ins_dt        := null;
               o_upd_dt        := null;
        else
            -- CID指定処理
            -- CIDが見つかった場合
            open oauth_corp_cur(i_cid);
            fetch oauth_corp_cur into oauth_corp_rec;
            if oauth_corp_cur%FOUND then
                case i_kbn
                when 'S' then
                      i_cid           := oauth_corp_rec.cid;
                      i_passwd        := oauth_corp_rec.passwd;
                      i_cname         := oauth_corp_rec.cname;
                      i_cname_kana    := oauth_corp_rec.cname_kana;
                      i_addr          := oauth_corp_rec.addr;
                      i_post          := oauth_corp_rec.post;
                      i_tel           := oauth_corp_rec.tel;
                      i_dept          := oauth_corp_rec.dept;
                      i_s_date        := oauth_corp_rec.s_date;
                      i_e_date        := oauth_corp_rec.e_date;
                      i_sales_id      := oauth_corp_rec.sales_id;
                      i_other_maddr   := oauth_corp_rec.other_maddr;
                      i_end_flg       := oauth_corp_rec.end_flg;
                      i_usage         := oauth_corp_rec.usage;
                      o_ins_dt        := oauth_corp_rec.ins_dt;
                      o_upd_dt        := oauth_corp_rec.upd_dt;

                      open zdc_uid_cur(i_sales_id);      -- DBリンク越しに見ているテーブルを含めたSELECT ～FOR UPDATEは出来ないので、USERMEI表示はカーソルで制御
                      fetch zdc_uid_cur into zdc_uid_rec;
                          w_usermei := zdc_uid_rec.usermei;
                          w_cnt := w_cnt + 1;
                          o_info(w_cnt) := 'cid'          || ':"' || oauth_corp_rec.cid          || '",' ||
                                           'passwd'       || ':"' || oauth_corp_rec.passwd       || '",' ||
                                           'cname'        || ':"' || oauth_corp_rec.cname        || '",' ||
                                           'cname_kana'   || ':"' || oauth_corp_rec.cname_kana   || '",' ||
                                           'addr'         || ':"' || oauth_corp_rec.addr         || '",' ||
                                           'post'         || ':"' || oauth_corp_rec.post         || '",' ||
                                           'tel'          || ':"' || oauth_corp_rec.tel          || '",' ||
                                           'dept'         || ':"' || oauth_corp_rec.dept         || '",' ||
                                           's_date'       || ':"' || oauth_corp_rec.s_date       || '",' ||
                                           'e_date'       || ':"' || oauth_corp_rec.e_date       || '",' ||
                                           'sales_id'     || ':"' || oauth_corp_rec.sales_id     || '",' ||
                                           'usermei'      || ':"' || w_usermei                   || '",' ||
                                           'other_maddr'  || ':"' || oauth_corp_rec.other_maddr  || '",' ||
                                           'end_flg'      || ':"' || oauth_corp_rec.end_flg      || '",' ||
                                           'usage'        || ':"' || oauth_corp_rec.usage        || '",' ||
                                           'ins_dt'       || ':"' || oauth_corp_rec.ins_dt       || '",' ||
                                           'upd_dt'       || ':"' || oauth_corp_rec.upd_dt       || '"';
                          o_cnt := 1;
                          w_rtncd := '0000';

                      close zdc_uid_cur;
                      o_rtncd := w_rtncd;

                when 'I' then
                      w_rtncd := '0002';
                      o_rtncd := w_rtncd;
                      -- テーブル更新ログ書き込み
                      insert into api20_tbl_updt_log
                      values(sysdate,'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID有りエラー');
                      commit;

                when 'U' then
                      open zdc_uid_cur(i_sales_id);
                      fetch zdc_uid_cur into zdc_uid_rec;
                      if zdc_uid_cur%FOUND then

                          -- 企業マスタデータ更新
                          update oauth_corp_mst
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
                              upd_dt       = sysdate                                  -- 更新日（YYYYMMDDHHMMSS）
                          where CURRENT OF oauth_corp_cur;
                          commit;

                          w_rtncd := '0000';
                          o_rtncd := w_rtncd;

                          -- テーブル更新ログ書き込み
                          insert into api20_tbl_updt_log
                          values(sysdate,'OAUTH_MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, null);
                          commit;

                           P_REFRESH( 'OAUTH_MVIEW', w_proc_rtncd );

                           -- テーブル更新ログ書き込み
                           insert into api20_tbl_updt_log
                           values(sysdate,'OAUTH_MST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
                           commit;

--                                -- API企業マスタ更新用メール送信
--                                corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);
--
--                                   if w_n_rtncd_mail <> 0 then
--                                     if w_n_rtncd_mail = 1 then
--                                        w_c_rtncd_mail := '0001';
--                                     else
--                                        w_c_rtncd_mail := '0009';
--                                     end if;
--                                   else
--                                     w_c_rtncd_mail := '0000';
--                                   end if;
--
--                                   -- テーブル更新ログ書き込み
--                                   insert into api20_tbl_updt_log
--                                   values(sysdate, 'MST','MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
--                                   commit;
--
                      else
                          w_rtncd := '0004';
                          o_rtncd := w_rtncd;
                          -- テーブル更新ログ書き込み
                          insert into api20_tbl_updt_log
                          values(sysdate, 'OAUTH_MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '担当者ID無しエラー（USERID:'||i_uid||')');
                          commit;

                      end if;

                      close zdc_uid_cur;

                when 'D' then
                      -- API企業マスタデータ削除
                      -- API企業マスタ更新用メール送信
--                      corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);
--
--                      if w_n_rtncd_mail <> 0 then
--                        if w_n_rtncd_mail = 1 then
--                          w_c_rtncd_mail := '0001';
--                        else
--                          w_c_rtncd_mail := '0009';
--                        end if;
--                      else
--                        w_c_rtncd_mail := '0000';
--                      end if;
--
--                        -- テーブル更新ログ書き込み
--                        insert into api20_tbl_updt_log
--                        values(sysdate,'OAUTH_MST', 'MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
--                        commit;

                      delete from oauth_corp_mst
                      where CURRENT OF oauth_corp_cur;

                      w_rtncd := '0000';
                      o_rtncd := w_rtncd;

                      -- テーブル更新ログ書き込み
                      insert into api20_tbl_updt_log
                      values(sysdate, 'OAUTH_MST','TABLE', i_kbn, i_uid, i_cid, w_rtncd,null);
                      commit;

                      P_REFRESH( 'OAUTH_MVIEW', w_proc_rtncd );

                      -- テーブル更新ログ書き込み
                      insert into api20_tbl_updt_log
                      values(sysdate, 'OAUTH_MST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, null);
                      commit;

                else
                    w_rtncd := '0099';
                    o_rtncd := w_rtncd;
                end case;


            else
            --CIDが見つからない場合
                case i_kbn
                when 'S' then
                      w_rtncd := '0000';
                      o_rtncd := w_rtncd;

                when 'I' then
                      open zdc_uid_cur(i_sales_id);
                      fetch zdc_uid_cur into zdc_uid_rec;
                      if zdc_uid_cur%FOUND then
                          -- 企業マスタデータ追加
                          insert into oauth_corp_mst
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
                             sysdate                                 -- 更新日（YYYYMMDDHHMMSS）
                           );
                          commit;
                          w_rtncd := '0000';
                          o_rtncd := w_rtncd;
                             if w_rtncd = '0000' then
                                 -- テーブル更新ログ書き込み
                                 insert into api20_tbl_updt_log
                                 values(sysdate, 'OAUTH_MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd,null);
                                 commit;

                                 P_REFRESH( 'OAUTH_MVIEW', w_proc_rtncd );

                                 -- テーブル更新ログ書き込み
                                 insert into api20_tbl_updt_log
                                 values(sysdate, 'MST','MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd,null);
                                 commit;

--                                   -- API企業マスタ更新用メール送信
--                                   corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail);
--
--                                   if w_n_rtncd_mail <> 0 then
--                                     if w_n_rtncd_mail = 1 then
--                                        w_c_rtncd_mail := '0001';
--                                     else
--                                        w_c_rtncd_mail := '0009';
--                                     end if;
--                                   else
--                                     w_c_rtncd_mail := '0000';
--                                   end if;
--
--                                   -- テーブル更新ログ書き込み
--                                   insert into api20_tbl_updt_log
--                                   values(sysdate,'MST', 'MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null);
                             end if;
                      else
                          --レコードがなければ
                          w_rtncd := '0004';
                          o_rtncd := w_rtncd;
                          insert into api20_tbl_updt_log
                          values(sysdate,'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '担当者ID無しエラー（USERID:'||i_uid||')');
                          commit;
                      end if;
                      close zdc_uid_cur;

                when 'U' then
                    w_rtncd := '0001';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'OAUTH_MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID無しエラー');
                    commit;

                when 'D' then
                    w_rtncd := '0001';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'OAUTH_MST','TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID無しエラー');
                    commit;

                else
                    w_rtncd := '0099';
                end case;
            end if;
        close oauth_corp_cur;
        end if;
--    o_rtncd := 0;      -- 正常終了
    END IF;

  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
    values(sysdate,'OAUTH_MST',null, i_kbn, i_uid, i_cid, w_rtncd, '処理完了');
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
      values(sysdate, 'OAUTH_MST',null, i_kbn, i_uid, i_cid, w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;

  END p_corp_updt;



/*     端末認証 秘密鍵テーブル更新プロシージャ    */
/*     変更日            担当        内容         */
/*     2012/11/29        蛯澤        新規作成     */
/*     2013/01/25        蛯澤        outパラメータに秘密鍵を追加     */
/*     2013/01/30        蛯澤        更新項目に秘密鍵を追加     */
procedure p_key_updt (
  i_kbn          in     char,        -- 更新区分（S:検索、I:登録、U:更新、D:削除）
  i_uid          in     varchar2,    -- ユーザID
  i_cid          in out varchar2,    -- 企業ID
  i_key_num      in out number,      -- キー番号
  i_consumer_id  in out varchar2,    -- クライアントID
  i_service_name in out varchar2,    -- サービス名
  i_key          in out varchar2,    -- 秘密鍵
  i_pos          in     number,      -- 取得位置（複数検索時指定）
  i_cnt          in     number,      -- 取得件数（複数検索時指定）
  o_ins_dt       out    char,        -- 登録日（YYYYMMDDHHMMSS）
  o_upd_dt       out    char,        -- 更新日（YYYYMMDDHHMMSS）
  o_rtncd        out    char,        -- リターンコード
                                     --    '0000'：正常終了
                                     --    '0001'：企業ID無しエラー
                                     --    '0002'：該当データ無しエラー
                                     --    '0003'：クライアントID有りエラー
                                     --    '0004'：ユーザーID無しエラー
                                     --    '0099'：更新区分エラー
                                     --    '7001'：その他エラー
  o_err_msg      out    varchar2,    -- エラーメッセージ
  o_cnt          out    number,      -- 全データ件数
  o_info         out    tbl_type     -- 複数件返却情報（キー:バリュー形式）
) is

  -- 秘密鍵テーブルカーソル（複数件検索用）
  CURSOR key_search(i_cid          in    varchar2,
                    i_consumer_id  in    varchar2,
                    i_service_name in    varchar2,
                    i_pos          in    number,
                    i_cnt          in    number) IS
    select * from (
      select cid,
             key_num,
             consumer_id,
             service_name,
             key,
             to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(upd_dt, 'yyyymmddhh24miss') upd_dt,
             all_cnt,
             row_number() over (order by cid, key_num) rnum
      from (
        select cid,
               key_num,
               consumer_id,
               service_name,
               key,
               ins_dt,
               upd_dt,
               count(*) over () all_cnt
        from oauth_key_tbl
        where decode(i_cid,          null, 1, instr(cid,         i_cid))           != 0
          and decode(i_consumer_id,  null, 1, instr(consumer_id, i_consumer_id))   != 0
          and decode(i_service_name, null, 1, instr(service_name,i_service_name))  != 0
      )
    )
    where rnum between i_pos and (i_pos + i_cnt -1)
    order by rnum;

  -- 秘密鍵テーブルカーソル（更新時企業ID確認）
  CURSOR key_cur(i_cid      in    varchar2,
                 i_key_num  in    number ) IS
      select cid,
             key_num,
             consumer_id,
             service_name,
             key,
             to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
             to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
      from   oauth_key_tbl
      where  cid     = i_cid
      and    key_num = i_key_num
      for update;

  key_rec             key_cur%ROWTYPE;

  -- 秘密鍵テーブルカーソル（登録時クライアントID確認）
  CURSOR key_unique(i_cid         in varchar2,
                    i_consumer_id in varchar2) IS
      select cid,
             consumer_id
      from   oauth_key_tbl
      where  cid     = i_cid
      and    consumer_id = i_consumer_id;

  key_unique_rec             key_unique%ROWTYPE;


  -- 企業マスタカーソル
  CURSOR oauth_corp_cur(i_cid in char) is
    select cid,
           s_date,
           e_date
    from oauth_corp_mst
    where cid = i_cid;

  oauth_corp_rec        oauth_corp_cur%ROWTYPE;

  -- ワーク変数
  w_cnt          pls_integer;    -- 取得データ件数
  w_rtncd        char(4);        -- リターンコード
  w_msg          varchar2(200);  -- エラーメッセージ
  w_proc_rtncd   char(4);        -- リターンコード

BEGIN
  -- クリア
  o_rtncd   := '0000';
  w_rtncd   := '0000';
  o_cnt     := 0;
  w_cnt     := 0;
  o_err_msg := null;


  -- 複数件指定処理
  if i_kbn = 'S' and i_key_num is null then
    for key_srch_rec in key_search(i_cid,
                                   i_consumer_id,
                                   i_service_name,
                                   i_pos,
                                   i_cnt) loop
      w_cnt := w_cnt + 1;
      o_info(w_cnt) := 'cid'          || ':"' || key_srch_rec.cid          || '",' ||
                       'key_num'      || ':"' || key_srch_rec.key_num      || '",' ||
                       'consumer_id'  || ':"' || key_srch_rec.consumer_id  || '",' ||
                       'service_name' || ':"' || key_srch_rec.service_name || '",' ||
                       'key'          || ':"' || key_srch_rec.key          || '",' ||
                       'ins_dt'       || ':"' || key_srch_rec.ins_dt       || '",' ||
                       'upd_dt'       || ':"' || key_srch_rec.upd_dt       || '"';
      o_cnt := key_srch_rec.all_cnt;
    end loop;

    o_rtncd := '0000';            -- 正常終了

  else
    -- １クライアントID指定処理
    open oauth_corp_cur(i_cid);    -- OAUTH_CORP_MSTに企業IDがあるかどうか
    fetch oauth_corp_cur into oauth_corp_rec;
    if oauth_corp_cur%FOUND then

        open key_cur(i_cid,i_key_num);    -- OAUTH_KEY_TBLにCIDとKEY_NUMがあるかどうか
        fetch key_cur into key_rec;
        if key_cur%FOUND then             -- OAUTH_KEY_TBLにCIDが該当する場合

            case i_kbn
              when 'S' then
                -- POS=1以外指定チェック
                if i_pos != 1 then
                    i_cid           := null;                -- 企業ID
                    i_key_num       := null;                -- キー
                    i_consumer_id   := null;                -- クライアントID
                    i_service_name  := null;                -- サービス名
                    i_key           := null;                -- 秘密鍵
                    o_ins_dt        := null;                -- 登録日（YYYYMMDDHHMMSS）
                    o_upd_dt        := null;                -- 更新日（YYYYMMDDHHMMSS）
                else
                    i_cid           := key_rec.cid;          -- 企業ID
                    i_key_num       := key_rec.key_num;      -- キー
                    i_consumer_id   := key_rec.consumer_id;  -- クライアントID
                    i_service_name  := key_rec.service_name; -- サービス名
                    i_key           := key_rec.key;          -- 秘密鍵
                    o_ins_dt        := key_rec.ins_dt;       -- 登録日（YYYYMMDDHHMMSS）
                    o_upd_dt        := key_rec.upd_dt;       -- 更新日（YYYYMMDDHHMMSS）

                  w_cnt := w_cnt + 1;
                  o_info(w_cnt) := 'cid'         || ':"' || key_rec.cid            || '",' ||
                                   'key_num'     || ':"' || key_rec.key_num        || '",' ||
                                   'consumer_id' || ':"' || key_rec.consumer_id    || '",' ||
                                   'service_name'|| ':"' || key_rec.service_name   || '",' ||
                                   'key'         || ':"' || key_rec.key            || '",' ||
                                   'ins_dt'      || ':"' || key_rec.ins_dt         || '",' ||
                                   'upd_dt'      || ':"' || key_rec.upd_dt         || '"';
                  o_cnt := 1;
                end if;
                w_rtncd := '0000';
                o_rtncd := w_rtncd;

              when 'I' then
                    w_rtncd := '0003';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'OAUTH_KEY','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, 'クライアントID有りエラー');
                    commit;

              when 'U' then
                   update oauth_key_tbl
                   set consumer_id  = i_consumer_id,   -- 更新用クライアントID
                       key_num      = i_key_num,       -- キー
                       service_name = i_service_name,  -- サービス名
                       key          = i_key,           -- 秘密鍵
                       upd_dt       = sysdate          -- 更新日（YYYYMMDDHHMMSS）
                   where CURRENT OF key_cur;
                   w_rtncd := '0000';
                   o_rtncd := w_rtncd;

                   insert into api20_tbl_updt_log
                   values(sysdate, 'OAUTH_KEY','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
                   commit;

                   P_REFRESH( 'OAUTH_MVIEW', w_proc_rtncd );

                   -- テーブル更新ログ書き込み
                   insert into api20_tbl_updt_log
                   values(sysdate, 'OAUTH_KEY','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                   commit;

              when 'D' then
                   delete from oauth_key_tbl
                   where CURRENT OF key_cur;
                   commit;
                   w_rtncd := '0000';
                   o_rtncd := w_rtncd;

                   insert into api20_tbl_updt_log
                   values(sysdate, 'OAUTH_KEY','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
                   commit;

                   P_REFRESH( 'OAUTH_MVIEW', w_proc_rtncd );

                   -- テーブル更新ログ書き込み
                   insert into api20_tbl_updt_log
                   values(sysdate, 'OAUTH_KEY','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                   commit;

              else
                w_rtncd := '0099';
              end case;

        else   -- OAUTH_KEY_TBLにCIDが該当しない場合

              case i_kbn
                when 'S' then
                    w_rtncd := '0002';
                    o_rtncd := w_rtncd;

                when 'I' then
                    open key_unique(i_cid,i_consumer_id);
                    fetch key_unique into key_unique_rec;
                    if key_unique%FOUND then
                        w_rtncd := '0003';
                        o_rtncd := w_rtncd;
                        insert into api20_tbl_updt_log
                        values(sysdate, 'OAUTH_KEY','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, 'クライアントID有りエラー');
                        commit;
                    else

                        -- KEY_NUM自動発番（KEY_NUMがNULLの場合）
                        if i_key_num is null then
                            select nvl(max(key_num), 0) into i_key_num
                            from oauth_key_tbl
                            where cid = i_cid;
                            i_key_num := i_key_num + 1;
                        end if;

                        -- 秘密鍵テーブルデータ追加
                        insert into oauth_key_tbl
                        values(i_cid,              -- 企業ID
                               i_key_num,          -- キー
                               i_consumer_id,      -- クライアントID
                               i_service_name,     -- サービス名
                               i_key,              -- 秘密鍵
                               sysdate,            -- 登録日（YYYYMMDDHHMMSS）
                               sysdate             -- 更新日（YYYYMMDDHHMMSS）
                        );
                        commit;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                        insert into api20_tbl_updt_log
                        values(sysdate, 'OAUTH_KEY','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, null);
                        commit;

                        P_REFRESH( 'OAUTH_MVIEW', w_proc_rtncd );

                        -- テーブル更新ログ書き込み
                        insert into api20_tbl_updt_log
                        values(sysdate, 'OAUTH_KEY','MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd,null);
                        commit;
                    end if;
                    close key_unique;

                when 'U' then
                    w_rtncd := '0002';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'OAUTH_KEY','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '該当データ無しエラー');
                    commit;

                when 'D' then
                    w_rtncd := '0002';
                    o_rtncd := w_rtncd;
                    insert into api20_tbl_updt_log
                    values(sysdate, 'OAUTH_KEY','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '該当データ無しエラー');
                    commit;

                else
                    w_rtncd := '0099';
                    o_rtncd := w_rtncd;
              end case;

        end if;
        close key_cur;

    else
        w_rtncd := '0001';
        insert into api20_tbl_updt_log
        values(sysdate, 'OAUTH_KEY','TABLE', i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, '企業ID無しエラー');
        commit;

        o_rtncd := w_rtncd;

    end if;
    close oauth_corp_cur;

  end if;
  -- テーブル更新ログ書き込み
  insert into api20_tbl_updt_log
    values(sysdate,'OAUTH_KEY',null, i_kbn, i_uid, i_cid, w_rtncd, '処理完了');
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
      values(sysdate, 'OAUTH_KEY',null, i_kbn, i_uid, i_cid||' key_num:'||to_char(i_key_num), w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;

END p_key_updt;

/*     端末認証 補足テーブル更新プロシージャ      */
/*     変更日            担当        内容         */
/*     2012/11/29        蛯澤        新規作成     */
procedure p_hosoku_tbl_updt (
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
) is

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
        from oauth_hosoku_tbl
        where decode(i_corp_id,       null, 1, instr(corp_id,       i_corp_id))       != 0
          and decode(i_hosoku_kbn,    null, 1, instr(hosoku_kbn,    i_hosoku_kbn))    != 0
          and decode(i_hosoku_title,  null, 1, instr(hosoku_title,  i_hosoku_title))  != 0
          and decode(i_hosoku_detail, null, 1, instr(hosoku_detail, i_hosoku_detail)) != 0
          and decode(i_userid,        null, 1, instr(userid,        i_userid))        != 0
      ) a , zdc_uid z where a.userid = z.userid
    )
    where rnum between i_pos and (i_pos + i_cnt -1)
    order by rnum;

  -- 端末認証 補足テーブルカーソル（ID指定更新用）
  cursor hosoku_cur(i_corp_id in char, i_key_num in number) is
    select corp_id,
           key_num,
           hosoku_kbn,
           hosoku_title,
           hosoku_detail,
           userid,
           to_char(ins_dt, 'yyyymmddhh24miss') ins_dt,
           to_char(upd_dt, 'yyyymmddhh24miss') upd_dt
    from oauth_hosoku_tbl
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
  w_rtncd   := '0000';
  o_err_msg := null;
  o_cnt     := 0;
  w_cnt     := 0;

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
                  update oauth_hosoku_tbl
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
                  delete from oauth_hosoku_tbl
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
                      from oauth_hosoku_tbl
                      where corp_id = i_corp_id;
                      i_key_num := i_key_num + 1;
                  end if;

                  insert into oauth_hosoku_tbl
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
    values(sysdate, 'OAUTH_HSK',null, i_kbn, i_uid, i_corp_id||' '||to_char(i_key_num), w_rtncd, null);
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
      values(sysdate, 'OAUTH_HSK', null, i_kbn, i_uid, i_corp_id||' '||to_char(i_key_num), w_rtncd, w_msg);
    commit;
    o_rtncd := w_rtncd;
    o_err_msg := w_msg;
end p_hosoku_tbl_updt;

end p_oauth_pkg;