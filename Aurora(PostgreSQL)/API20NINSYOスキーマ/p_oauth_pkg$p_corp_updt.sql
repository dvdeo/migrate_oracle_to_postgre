CREATE OR REPLACE FUNCTION api20ninsyo.p_oauth_pkg$p_corp_updt(IN i_kbn TEXT, IN i_uid TEXT, INOUT i_cid TEXT, INOUT i_passwd TEXT, INOUT i_cname TEXT, INOUT i_cname_kana TEXT, INOUT i_addr TEXT, INOUT i_post TEXT, INOUT i_tel TEXT, INOUT i_dept TEXT, INOUT i_s_date TEXT, INOUT i_e_date TEXT, IN i_s_date_op TEXT, IN i_e_date_op TEXT, INOUT i_sales_id TEXT, INOUT i_other_maddr TEXT, INOUT i_end_flg TEXT, INOUT i_usage TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_ins_dt TEXT, OUT o_upd_dt TEXT, OUT o_rtncd TEXT, OUT o_err_msg TEXT, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* 企業情報取得カーソル（複数件検索用） */
DECLARE
    /*
    [5605 - Severity CRITICAL - PostgreSQL doesn't support use of dblinks. Use another method for this functionality., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
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
        ORDER BY e_date asc,cid asc
    */
    /* ORDER BY rnum; */
    /* 企業情報取得カーソル */
    oauth_corp_cur CURSOR (i_cid TEXT) FOR
    SELECT
        cid, passwd, cname, cname_kana, addr, post, tel, dept, aws_oracle_ext.TO_CHAR(s_date, 'yyyymmddhh24miss') AS s_date, aws_oracle_ext.TO_CHAR(e_date, 'yyyymmddhh24miss') AS e_date, sales_id, other_maddr, end_flg, usage, aws_oracle_ext.TO_CHAR(ins_dt, 'yyyymmddhh24miss') AS ins_dt, aws_oracle_ext.TO_CHAR(upd_dt, 'yyyymmddhh24miss') AS upd_dt
        FROM api20ninsyo.oauth_corp_mst
        WHERE cid = i_cid
        FOR UPDATE;
    oauth_corp_rec record
    /* ユーザマスタカーソル */
    /*
    [5605 - Severity CRITICAL - PostgreSQL doesn't support use of dblinks. Use another method for this functionality., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    CURSOR zdc_uid_cur(i_sales_id in char)
      IS
        select userid,usermei
        from zdc_uid
        where userid = i_sales_id
    */;
    zdc_uid_rec record
    /* ワーク変数 */;
    w_msg CHARACTER VARYING(200)
    /* エラーメッセージ */;
    w_usermei CHARACTER VARYING(40)
    /* ユーザー名 */;
    w_n_rtncd_mail DOUBLE PRECISION
    /* リターンコード(企業マスタ更新用メール送信プロシージャ用) */;
    w_c_rtncd_mail CHARACTER(4)
    /* リターンコード(企業マスタ更新用メール送信プロシージャ用) */;
    w_cnt INTEGER
    /* 取得データ件数 */;
    w_proc_rtncd CHARACTER(4)
    /* リターンコード */;
    w_rtncd CHARACTER(4);
    oauth_corp_cur$FOUND BOOLEAN DEFAULT false;
    zdc_uid_cur$FOUND BOOLEAN DEFAULT false;
/* リターンコード */
/* うるう年補正（2/29 -> 2/28） */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20ninsyo.p_oauth_pkg$p_corp_updt');

    IF aws_oracle_ext.substr(i_s_date, 5, 4) = '0229' THEN
        i_s_date := CONCAT_WS('', aws_oracle_ext.substr(i_s_date, 1, 4), '0228', aws_oracle_ext.substr(i_s_date, 9));
    END IF
    /* 初期化 */;
    o_rtncd := '0000';
    w_rtncd := '0000';
    w_usermei := NULL;
    o_err_msg := NULL;
    o_cnt := 0;
    w_cnt := 0
    /* CIDの指定がない時->複数件抽出 */;

    IF i_kbn = 'S' AND (i_cid IS NULL OR aws_oracle_ext.substr(i_cid, 1, 1) = '*') THEN
        FOR oauth_corp_search_rec IN oauth_corp_search_cur (i_cid, i_passwd, i_cname, i_cname_kana, i_addr, i_post, i_tel, i_dept, i_s_date, i_e_date, i_s_date_op, i_e_date_op, i_sales_id, i_other_maddr, i_end_flg, i_usage, i_pos, i_cnt) LOOP
            w_cnt := w_cnt + 1
            /*
            [9993 - Severity CRITICAL - Unable to transform statement due to references to unresolved object. Verify if unresolved object is present in the database. If it isn't, check the object name or add the object. If the object is present, please submit report to developers.]
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
                                      'upd_dt'       || ':"' || oauth_corp_search_rec.upd_dt       || '"'
            */;
            o_cnt := oauth_corp_search_rec.all_cnt;
        END LOOP;
        o_rtncd := '0000';
    /* CIDを指定している場合->1件を抽出 */
    /* CID指定時のPOS=1以外指定チェック */
    ELSE
        IF i_kbn = 'S' AND i_pos != 1 THEN
            w_rtncd := '0000';
            o_rtncd := w_rtncd;
            i_cid := NULL;
            i_passwd := NULL;
            i_cname := NULL;
            i_cname_kana := NULL;
            i_addr := NULL;
            i_post := NULL;
            i_tel := NULL;
            i_dept := NULL;
            i_s_date := NULL;
            i_e_date := NULL;
            i_sales_id := NULL;
            i_other_maddr := NULL;
            i_end_flg := NULL;
            i_usage := NULL;
            o_ins_dt := NULL;
            o_upd_dt := NULL;
        /* CID指定処理 */
        /* CIDが見つかった場合 */
        ELSE
            OPEN oauth_corp_cur (i_cid);
            FETCH oauth_corp_cur INTO oauth_corp_rec;
            oauth_corp_cur$FOUND := FOUND;

            IF oauth_corp_cur$FOUND THEN
                CASE i_kbn
                    WHEN 'S' THEN
                        i_cid := oauth_corp_rec.cid;
                        i_passwd := oauth_corp_rec.passwd;
                        i_cname := oauth_corp_rec.cname;
                        i_cname_kana := oauth_corp_rec.cname_kana;
                        i_addr := oauth_corp_rec.addr;
                        i_post := oauth_corp_rec.post;
                        i_tel := oauth_corp_rec.tel;
                        i_dept := oauth_corp_rec.dept;
                        i_s_date := oauth_corp_rec.s_date;
                        i_e_date := oauth_corp_rec.e_date;
                        i_sales_id := oauth_corp_rec.sales_id;
                        i_other_maddr := oauth_corp_rec.other_maddr;
                        i_end_flg := oauth_corp_rec.end_flg;
                        i_usage := oauth_corp_rec.usage;
                        o_ins_dt := oauth_corp_rec.ins_dt;
                        o_upd_dt := oauth_corp_rec.upd_dt
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        open zdc_uid_cur(i_sales_id)
                        */
                        /* DBリンク越しに見ているテーブルを含めたSELECT ～FOR UPDATEは出来ないので、USERMEI表示はカーソルで制御 */
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        fetch zdc_uid_cur into zdc_uid_rec
                        */;
                        zdc_uid_cur$FOUND := FOUND;
                        w_usermei := zdc_uid_rec.usermei;
                        w_cnt := w_cnt + 1;
                        PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20ninsyo.p_oauth_pkg$p_corp_updt', CONCAT_WS('', 'cid', ':"', oauth_corp_rec.cid, '",', 'passwd', ':"', oauth_corp_rec.passwd, '",', 'cname', ':"', oauth_corp_rec.cname, '",', 'cname_kana', ':"', oauth_corp_rec.cname_kana, '",', 'addr', ':"', oauth_corp_rec.addr, '",', 'post', ':"', oauth_corp_rec.post, '",', 'tel', ':"', oauth_corp_rec.tel, '",', 'dept', ':"', oauth_corp_rec.dept, '",', 's_date', ':"', oauth_corp_rec.s_date, '",', 'e_date', ':"', oauth_corp_rec.e_date, '",', 'sales_id', ':"', oauth_corp_rec.sales_id, '",', 'usermei', ':"', w_usermei, '",', 'other_maddr', ':"', oauth_corp_rec.other_maddr, '",', 'end_flg', ':"', oauth_corp_rec.end_flg, '",', 'usage', ':"', oauth_corp_rec.usage, '",', 'ins_dt', ':"', oauth_corp_rec.ins_dt, '",', 'upd_dt', ':"', oauth_corp_rec.upd_dt, '"'));
                        o_cnt := 1;
                        w_rtncd := '0000'
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        close zdc_uid_cur
                        */;
                        o_rtncd := w_rtncd;
                    WHEN 'I' THEN
                        w_rtncd := '0002';
                        o_rtncd := w_rtncd
                        /* テーブル更新ログ書き込み */;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID有りエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    WHEN 'U' THEN
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        open zdc_uid_cur(i_sales_id)
                        */
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        fetch zdc_uid_cur into zdc_uid_rec
                        */
                        zdc_uid_cur$FOUND := FOUND;

                        IF zdc_uid_cur$FOUND
                        /* 企業マスタデータ更新 */
                        THEN
                            UPDATE api20ninsyo.oauth_corp_mst
                            SET cid = i_cid
                            /* 企業ID */, passwd = i_passwd
                            /* パスワード */, cname = i_cname
                            /* 企業名 */, cname_kana = i_cname_kana
                            /* 企業名カナ */, addr = i_addr
                            /* 住所 */, post = i_post
                            /* 郵便番号 */, tel = i_tel
                            /* 電話番号 */, dept = i_dept
                            /* 部署 */, s_date = aws_oracle_ext.TO_DATE(i_s_date, 'yyyymmddhh24miss')
                            /* サービス開始日付（YYYYMMDDHHMMSS） */, e_date = aws_oracle_ext.TO_DATE(i_e_date, 'yyyymmddhh24miss')
                            /* サービス終了日付（YYYYMMDDHHMMSS） */, sales_id = i_sales_id
                            /* 担当営業ユーザID */, other_maddr = i_other_maddr
                            /* メールアドレス */, end_flg = COALESCE(i_end_flg, '0')
                            /* 契約終了フラグ（0:利用中、1:終了） */, usage = i_usage
                            /* 用途 */, upd_dt = aws_oracle_ext.SYSDATE()
                            /* 更新日（YYYYMMDDHHMMSS） */
                                WHERE CURRENT OF oauth_corp_cur
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                            w_rtncd := '0000';
                            o_rtncd := w_rtncd
                            /* テーブル更新ログ書き込み */;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, NULL)
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                            SELECT
                                *
                                FROM api20ninsyo.p_refresh('OAUTH_MVIEW'::TEXT)
                                INTO w_proc_rtncd
                            /* テーブル更新ログ書き込み */;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, NULL)
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                        /* -- API企業マスタ更新用メール送信 */
                        /* corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail); */
                        /* */
                        /* if w_n_rtncd_mail <> 0 then */
                        /* if w_n_rtncd_mail = 1 then */
                        /* w_c_rtncd_mail := '0001'; */
                        /* else */
                        /* w_c_rtncd_mail := '0009'; */
                        /* end if; */
                        /* else */
                        /* w_c_rtncd_mail := '0000'; */
                        /* end if; */
                        /* */
                        /* -- テーブル更新ログ書き込み */
                        /* insert into api20_tbl_updt_log */
                        /* values(sysdate, 'MST','MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null); */
                        /* commit; */
                        /* */
                        ELSE
                            w_rtncd := '0004';
                            o_rtncd := w_rtncd
                            /* テーブル更新ログ書き込み */;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, CONCAT_WS('', '担当者ID無しエラー（USERID:', i_uid, ')'))
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                        END IF
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        close zdc_uid_cur
                        */;
                    WHEN 'D'
                    /* API企業マスタデータ削除 */
                    /* API企業マスタ更新用メール送信 */
                    /* corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail); */
                    /* */
                    /* if w_n_rtncd_mail <> 0 then */
                    /* if w_n_rtncd_mail = 1 then */
                    /* w_c_rtncd_mail := '0001'; */
                    /* else */
                    /* w_c_rtncd_mail := '0009'; */
                    /* end if; */
                    /* else */
                    /* w_c_rtncd_mail := '0000'; */
                    /* end if; */
                    /* */
                    /* -- テーブル更新ログ書き込み */
                    /* insert into api20_tbl_updt_log */
                    /* values(sysdate,'OAUTH_MST', 'MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null); */
                    /* commit; */
                    THEN
                        DELETE FROM api20ninsyo.oauth_corp_mst
                            WHERE CURRENT OF oauth_corp_cur;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd
                        /* テーブル更新ログ書き込み */;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'TABLE', i_kbn, i_uid, i_cid, w_rtncd, NULL)
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                        SELECT
                            *
                            FROM api20ninsyo.p_refresh('OAUTH_MVIEW'::TEXT)
                            INTO w_proc_rtncd
                        /* テーブル更新ログ書き込み */;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, NULL)
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    ELSE
                        w_rtncd := '0099';
                        o_rtncd := w_rtncd;
                END CASE;
            /* CIDが見つからない場合 */
            ELSE
                CASE i_kbn
                    WHEN 'S' THEN
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                    WHEN 'I' THEN
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        open zdc_uid_cur(i_sales_id)
                        */
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        fetch zdc_uid_cur into zdc_uid_rec
                        */
                        zdc_uid_cur$FOUND := FOUND;

                        IF zdc_uid_cur$FOUND
                        /* 企業マスタデータ追加 */
                        THEN
                            INSERT INTO api20ninsyo.oauth_corp_mst
                            VALUES (i_cid
                            /* 企業ID */, i_passwd
                            /* パスワード */, i_cname
                            /* 企業名 */, i_cname_kana
                            /* 企業名カナ */, i_addr
                            /* 住所 */, i_post
                            /* 郵便番号 */, i_tel
                            /* 電話番号 */, i_dept
                            /* 部署 */, aws_oracle_ext.TO_DATE(i_s_date, 'yyyymmddhh24miss')
                            /* サービス開始日付（YYYYMMDDHHMMSS） */, aws_oracle_ext.TO_DATE(i_e_date, 'yyyymmddhh24miss')
                            /* サービス終了日付（YYYYMMDDHHMMSS） */, i_sales_id
                            /* 担当営業ユーザID */, i_other_maddr
                            /* メールアドレス */, COALESCE(i_end_flg, '0')
                            /* 契約終了フラグ（0:利用中、1:終了） */, i_usage
                            /* 用途 */, aws_oracle_ext.SYSDATE()
                            /* 登録日（YYYYMMDDHHMMSS） */, aws_oracle_ext.SYSDATE()
                            /* 更新日（YYYYMMDDHHMMSS） */)
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                            w_rtncd := '0000';
                            o_rtncd := w_rtncd;

                            IF w_rtncd = '0000'
                            /* テーブル更新ログ書き込み */
                            THEN
                                INSERT INTO api20ninsyo.api20_tbl_updt_log
                                VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, NULL)
                                /*
                                [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                                commit
                                */;
                                SELECT
                                    *
                                    FROM api20ninsyo.p_refresh('OAUTH_MVIEW'::TEXT)
                                    INTO w_proc_rtncd
                                /* テーブル更新ログ書き込み */;
                                INSERT INTO api20ninsyo.api20_tbl_updt_log
                                VALUES (aws_oracle_ext.SYSDATE(), 'MST', 'MVIEW', i_kbn, i_sales_id, i_cid, w_proc_rtncd, NULL)
                                /*
                                [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                                commit
                                */;
                            /* -- API企業マスタ更新用メール送信 */
                            /* corp_mst_update_mail(i_cid, i_kbn, i_uid, w_n_rtncd_mail); */
                            /* */
                            /* if w_n_rtncd_mail <> 0 then */
                            /* if w_n_rtncd_mail = 1 then */
                            /* w_c_rtncd_mail := '0001'; */
                            /* else */
                            /* w_c_rtncd_mail := '0009'; */
                            /* end if; */
                            /* else */
                            /* w_c_rtncd_mail := '0000'; */
                            /* end if; */
                            /* */
                            /* -- テーブル更新ログ書き込み */
                            /* insert into api20_tbl_updt_log */
                            /* values(sysdate,'MST', 'MAIL', i_kbn, i_uid, i_cid, w_c_rtncd_mail, null); */
                            END IF;
                        /* レコードがなければ */
                        ELSE
                            w_rtncd := '0004';
                            o_rtncd := w_rtncd;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, CONCAT_WS('', '担当者ID無しエラー（USERID:', i_uid, ')'))
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                        END IF
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        close zdc_uid_cur
                        */;
                    WHEN 'U' THEN
                        w_rtncd := '0001';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID無しエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    WHEN 'D' THEN
                        w_rtncd := '0001';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', 'TABLE', i_kbn, i_sales_id, i_cid, w_rtncd, '企業ID無しエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    ELSE
                        w_rtncd := '0099';
                END CASE;
            END IF;
            CLOSE oauth_corp_cur;
        END IF;
    /* o_rtncd := 0;      -- 正常終了 */
    END IF
    /* テーブル更新ログ書き込み */;
    INSERT INTO api20ninsyo.api20_tbl_updt_log
    VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', NULL, i_kbn, i_uid, i_cid, w_rtncd, '処理完了')
    /*
    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
    commit
    */;
    o_rtncd := w_rtncd;
    o_err_msg := NULL;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20ninsyo.p_oauth_pkg$p_corp_updt', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20ninsyo.p_oauth_pkg$p_corp_updt');
    EXCEPTION
        WHEN others THEN
            NULL;
            w_rtncd := '7001'
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg      := substrb(SQLERRM,1,200)
            */
            /* テーブル更新ログ書き込み */;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_MST', NULL, i_kbn, i_uid, i_cid, w_rtncd, w_msg)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
            o_err_msg := w_msg;
END;
$BODY$
LANGUAGE  plpgsql;