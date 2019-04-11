CREATE OR REPLACE FUNCTION api20ninsyo.p_api20_hosoku_pkg$p_api20_hosoku_tbl_updt(IN i_kbn TEXT, IN i_uid TEXT, INOUT i_corp_id TEXT, INOUT i_key_num DOUBLE PRECISION, INOUT i_hosoku_kbn TEXT, INOUT i_hosoku_title TEXT, INOUT i_hosoku_detail TEXT, INOUT i_userid TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_ins_dt TEXT, OUT o_upd_dt TEXT, OUT o_rtncd TEXT, OUT o_err_msg TEXT, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* API2.0補足テーブルカーソル（複数件検索用） */
DECLARE
    /*
    [5605 - Severity CRITICAL - PostgreSQL doesn't support use of dblinks. Use another method for this functionality., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
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
        order by rnum
    */
    /* API2.0補足テーブルカーソル（ID指定更新用） */
    hosoku_cur CURSOR (i_corp_id TEXT, i_key_num DOUBLE PRECISION) FOR
    SELECT
        corp_id, key_num, hosoku_kbn, hosoku_title, hosoku_detail, userid, aws_oracle_ext.TO_CHAR(ins_dt, 'yyyymmddhh24miss') AS ins_dt, aws_oracle_ext.TO_CHAR(upd_dt, 'yyyymmddhh24miss') AS upd_dt
        FROM api20ninsyo.api20_hosoku_tbl
        WHERE corp_id = i_corp_id AND key_num = i_key_num
        FOR UPDATE;
    hosoku_rec record
    /* ユーザマスタカーソル */
    /*
    [5605 - Severity CRITICAL - PostgreSQL doesn't support use of dblinks. Use another method for this functionality., 5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
    CURSOR zdc_uid_cur(i_uid char)
      IS
        select userid,usermei
        from zdc_uid
        where userid = i_uid
    */;
    zdc_uid_rec record
    /* ワーク変数 */;
    w_cnt INTEGER
    /* 取得データ件数 */;
    w_rtncd CHARACTER(4)
    /* リターンコード */;
    w_msg CHARACTER VARYING(200)
    /* エラーメッセージ */;
    w_usermei CHARACTER VARYING(40);
    hosoku_cur$FOUND BOOLEAN DEFAULT false;
/* ユーザー名 */
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20ninsyo.p_api20_hosoku_pkg$p_api20_hosoku_tbl_updt');
    o_rtncd := '0000';
    o_err_msg := NULL;
    o_cnt := 0;
    w_cnt := 0;
    w_rtncd := '0000'
    /* 検索指定・KEY_NUM指定チェック */;

    IF i_kbn = 'S' AND i_key_num IS NULL THEN
        FOR hosoku_rec IN hosoku_search (i_corp_id, i_hosoku_kbn, i_hosoku_title, i_hosoku_detail, i_userid, i_pos, i_cnt) LOOP
            w_cnt := w_cnt + 1
            /*
            [9993 - Severity CRITICAL - Unable to transform statement due to references to unresolved object. Verify if unresolved object is present in the database. If it isn't, check the object name or add the object. If the object is present, please submit report to developers.]
            o_info(w_cnt) := 'corp_id'       || ':"' || hosoku_rec.corp_id       || '",' ||
                                       'key_num'       || ':"' || hosoku_rec.key_num       || '",' ||
                                       'hosoku_kbn'    || ':"' || hosoku_rec.hosoku_kbn    || '",' ||
                                       'hosoku_title'  || ':"' || hosoku_rec.hosoku_title  || '",' ||
                                       'hosoku_detail' || ':"' || hosoku_rec.hosoku_detail || '",' ||
                                       'userid'        || ':"' || hosoku_rec.userid        || '",' ||
                                       'usermei'       || ':"' || hosoku_rec.usermei       || '",' ||
                                       'ins_dt'        || ':"' || hosoku_rec.ins_dt        || '",' ||
                                       'upd_dt'        || ':"' || hosoku_rec.upd_dt        || '"'
            */;
            o_cnt := hosoku_rec.all_cnt;
        END LOOP;
        o_rtncd := 0;
    /* 正常終了 */
    /* １ユーザ指定処理 */
    ELSE
        OPEN hosoku_cur (i_corp_id, i_key_num);
        FETCH hosoku_cur INTO hosoku_rec;
        hosoku_cur$FOUND := FOUND;

        IF hosoku_cur$FOUND THEN
            CASE i_kbn
                WHEN 'S'
                /* POS=1以外指定チェック */
                THEN
                    IF i_pos != 1 THEN
                        i_corp_id := NULL
                        /* 企業ID */;
                        i_key_num := NULL
                        /* キー */;
                        i_hosoku_kbn := NULL
                        /* 補足区分 */;
                        i_hosoku_title := NULL
                        /* 補足タイトル */;
                        i_hosoku_detail := NULL
                        /* 補足内容 */;
                        i_userid := NULL
                        /* ユーザID */;
                        o_ins_dt := NULL
                        /* 登録日（YYYYMMDDHHMMSS） */;
                        o_upd_dt := NULL;
                    /* 更新日（YYYYMMDDHHMMSS） */
                    ELSE
                        i_corp_id := hosoku_rec.corp_id
                        /* 企業ID */;
                        i_key_num := hosoku_rec.key_num
                        /* キー */;
                        i_hosoku_kbn := hosoku_rec.hosoku_kbn
                        /* 補足区分 */;
                        i_hosoku_title := hosoku_rec.hosoku_title
                        /* 補足タイトル */;
                        i_hosoku_detail := hosoku_rec.hosoku_detail
                        /* 補足内容 */;
                        i_userid := hosoku_rec.userid
                        /* ユーザID */;
                        o_ins_dt := hosoku_rec.ins_dt
                        /* 登録日（YYYYMMDDHHMMSS） */;
                        o_upd_dt := hosoku_rec.upd_dt
                        /* 更新日（YYYYMMDDHHMMSS） */
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        OPEN zdc_uid_cur(i_userid)
                        */
                        /* DBリンク越しに見ているテーブルを含めたSELECT ～FOR UPDATEは出来ないので、USERMEI表示はカーソルで制御 */
                        /*
                        [5578 - Severity CRITICAL - Unable to automatically transform the SELECT statement. Try rewriting the statement.]
                        fetch zdc_uid_cur into zdc_uid_rec
                        */;
                        w_usermei := zdc_uid_rec.usermei;
                        w_cnt := w_cnt + 1;
                        PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20ninsyo.p_api20_hosoku_pkg$p_api20_hosoku_tbl_updt', CONCAT_WS('', 'corp_id', ':"', hosoku_rec.corp_id, '",', 'key_num', ':"', hosoku_rec.key_num, '",', 'hosoku_kbn', ':"', hosoku_rec.hosoku_kbn, '",', 'hosoku_title', ':"', hosoku_rec.hosoku_title, '",', 'hosoku_detail', ':"', hosoku_rec.hosoku_detail, '",', 'userid', ':"', hosoku_rec.userid, '",', 'usermei', ':"', w_usermei, '",', 'ins_dt', ':"', hosoku_rec.ins_dt, '",', 'upd_dt', ':"', hosoku_rec.upd_dt, '"'));
                        o_cnt := 1;
                    END IF;
                WHEN 'I' THEN
                    w_rtncd := '0002';
                WHEN 'U' THEN
                    UPDATE api20ninsyo.api20_hosoku_tbl
                    SET corp_id = i_corp_id
                    /* 企業ID */, key_num = i_key_num
                    /* キー */, hosoku_kbn = i_hosoku_kbn
                    /* 補足区分 */, hosoku_title = i_hosoku_title
                    /* 補足タイトル */, hosoku_detail = i_hosoku_detail
                    /* 補足詳細 */, userid = i_userid
                    /* ユーザID（ログインユーザ） */, upd_dt = aws_oracle_ext.SYSDATE()
                    /* 更新日（YYYYMMDDHHMMSS） */
                        WHERE CURRENT OF hosoku_cur;
                    w_rtncd := '0000';
                WHEN 'D' THEN
                    DELETE FROM api20ninsyo.api20_hosoku_tbl
                        WHERE CURRENT OF hosoku_cur;
                    w_rtncd := '0000';
                ELSE
                    w_rtncd := '0099';
            END CASE;
        ELSE
            CASE i_kbn
                WHEN 'S' THEN
                    w_rtncd := '0001';
                WHEN 'I'
                /* KEY_NUM自動発番（KEY_NUMがNULLの場合） */
                THEN
                    IF i_key_num IS NULL THEN
                        SELECT
                            COALESCE(MAX(key_num), 0)
                            INTO STRICT i_key_num
                            FROM api20ninsyo.api20_hosoku_tbl
                            WHERE corp_id = i_corp_id;
                        i_key_num := i_key_num + 1;
                    END IF;
                    INSERT INTO api20ninsyo.api20_hosoku_tbl
                    VALUES (i_corp_id
                    /* 企業ID */, i_key_num
                    /* キー */, i_hosoku_kbn
                    /* 補足区分 */, i_hosoku_title
                    /* 補足タイトル */, i_hosoku_detail
                    /* 補足詳細 */, i_userid
                    /* ユーザID（ログインユーザ） */, aws_oracle_ext.SYSDATE()
                    /* 登録日（YYYYMMDDHHMMSS） */, aws_oracle_ext.SYSDATE()
                    /* 更新日（YYYYMMDDHHMMSS） */);
                    w_rtncd := '0000';
                WHEN 'U' THEN
                    w_rtncd := '0001';
                WHEN 'D' THEN
                    w_rtncd := '0001';
                ELSE
                    w_rtncd := '0099';
            END CASE;
        END IF;
        CLOSE hosoku_cur;
    END IF
    /* テーブル更新ログ書き込み */;
    INSERT INTO api20ninsyo.api20_tbl_updt_log
    VALUES (aws_oracle_ext.SYSDATE(), 'HOSOKU', NULL, i_kbn, i_uid, CONCAT_WS('', i_corp_id, ' ', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, NULL)
    /*
    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
    commit
    */;
    o_rtncd := w_rtncd;
    o_err_msg := NULL;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20ninsyo.p_api20_hosoku_pkg$p_api20_hosoku_tbl_updt', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20ninsyo.p_api20_hosoku_pkg$p_api20_hosoku_tbl_updt');
    EXCEPTION
        WHEN others THEN
            NULL;
            w_rtncd := '7001'
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg      	:= substrb(SQLERRM,1,200)
            */
            /* テーブル更新ログ書き込み */;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'HOSOKU', NULL, i_kbn, i_uid, CONCAT_WS('', i_corp_id, ' ', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, w_msg)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
            o_err_msg := w_msg;
END;
$BODY$
LANGUAGE  plpgsql;