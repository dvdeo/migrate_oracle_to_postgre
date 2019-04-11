CREATE OR REPLACE FUNCTION api20ninsyo.p_oauth_pkg$p_key_updt(IN i_kbn TEXT, IN i_uid TEXT, INOUT i_cid TEXT, INOUT i_key_num DOUBLE PRECISION, INOUT i_consumer_id TEXT, INOUT i_service_name TEXT, INOUT i_key TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_ins_dt TEXT, OUT o_upd_dt TEXT, OUT o_rtncd TEXT, OUT o_err_msg TEXT, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* 秘密鍵テーブルカーソル（複数件検索用） */
DECLARE
    key_search CURSOR (i_cid TEXT, i_consumer_id TEXT, i_service_name TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        *
        FROM (SELECT
            cid, key_num, consumer_id, service_name, key, aws_oracle_ext.TO_CHAR(ins_dt, 'yyyymmddhh24miss') AS ins_dt, aws_oracle_ext.TO_CHAR(upd_dt, 'yyyymmddhh24miss') AS upd_dt, all_cnt, ROW_NUMBER() OVER (ORDER BY cid, key_num) AS rnum
            FROM (SELECT
                cid, key_num, consumer_id, service_name, key, ins_dt, upd_dt, COUNT(*) OVER () AS all_cnt
                FROM api20ninsyo.oauth_key_tbl
                WHERE
                CASE i_cid
                    WHEN NULL THEN 1
                    ELSE aws_oracle_ext.INSTR(cid, i_cid)
                END != 0 AND
                CASE i_consumer_id
                    WHEN NULL THEN 1
                    ELSE aws_oracle_ext.INSTR(consumer_id, i_consumer_id)
                END != 0 AND
                CASE i_service_name
                    WHEN NULL THEN 1
                    ELSE aws_oracle_ext.INSTR(service_name, i_service_name)
                END != 0) AS var_sbq) AS var_sbq_2
        WHERE rnum BETWEEN i_pos AND (i_pos + i_cnt - 1)
        ORDER BY rnum
    /* 秘密鍵テーブルカーソル（更新時企業ID確認） */;
    key_cur CURSOR (i_cid TEXT, i_key_num DOUBLE PRECISION) FOR
    SELECT
        cid, key_num, consumer_id, service_name, key, aws_oracle_ext.TO_CHAR(ins_dt, 'yyyymmddhh24miss') AS ins_dt, aws_oracle_ext.TO_CHAR(upd_dt, 'yyyymmddhh24miss') AS upd_dt
        FROM api20ninsyo.oauth_key_tbl
        WHERE cid = i_cid AND key_num = i_key_num
        FOR UPDATE;
    key_rec record
    /* 秘密鍵テーブルカーソル（登録時クライアントID確認） */;
    key_unique CURSOR (i_cid TEXT, i_consumer_id TEXT) FOR
    SELECT
        cid, consumer_id
        FROM api20ninsyo.oauth_key_tbl
        WHERE cid = i_cid AND consumer_id = i_consumer_id;
    key_unique_rec record
    /* 企業マスタカーソル */;
    oauth_corp_cur CURSOR (i_cid TEXT) FOR
    SELECT
        cid, s_date, e_date
        FROM api20ninsyo.oauth_corp_mst
        WHERE cid = i_cid;
    oauth_corp_rec record
    /* ワーク変数 */;
    w_cnt INTEGER
    /* 取得データ件数 */;
    w_rtncd CHARACTER(4)
    /* リターンコード */;
    w_msg CHARACTER VARYING(200)
    /* エラーメッセージ */;
    w_proc_rtncd CHARACTER(4);
    oauth_corp_cur$FOUND BOOLEAN DEFAULT false;
    key_cur$FOUND BOOLEAN DEFAULT false;
    key_unique$FOUND BOOLEAN DEFAULT false;
/* リターンコード */
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20ninsyo.p_oauth_pkg$p_key_updt');
    o_rtncd := '0000';
    w_rtncd := '0000';
    o_cnt := 0;
    w_cnt := 0;
    o_err_msg := NULL
    /* 複数件指定処理 */;

    IF i_kbn = 'S' AND i_key_num IS NULL THEN
        FOR key_srch_rec IN key_search (i_cid, i_consumer_id, i_service_name, i_pos, i_cnt) LOOP
            w_cnt := w_cnt + 1;
            PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20ninsyo.p_oauth_pkg$p_key_updt', CONCAT_WS('', 'cid', ':"', key_srch_rec.cid, '",', 'key_num', ':"', key_srch_rec.key_num, '",', 'consumer_id', ':"', key_srch_rec.consumer_id, '",', 'service_name', ':"', key_srch_rec.service_name, '",', 'key', ':"', key_srch_rec.key, '",', 'ins_dt', ':"', key_srch_rec.ins_dt, '",', 'upd_dt', ':"', key_srch_rec.upd_dt, '"'));
            o_cnt := key_srch_rec.all_cnt;
        END LOOP;
        o_rtncd := '0000';
    /* 正常終了 */
    /* １クライアントID指定処理 */
    ELSE
        OPEN oauth_corp_cur (i_cid)
        /* OAUTH_CORP_MSTに企業IDがあるかどうか */;
        FETCH oauth_corp_cur INTO oauth_corp_rec;
        oauth_corp_cur$FOUND := FOUND;

        IF oauth_corp_cur$FOUND THEN
            OPEN key_cur (i_cid, i_key_num)
            /* OAUTH_KEY_TBLにCIDとKEY_NUMがあるかどうか */;
            FETCH key_cur INTO key_rec;
            key_cur$FOUND := FOUND;

            IF key_cur$FOUND
            /* OAUTH_KEY_TBLにCIDが該当する場合 */
            THEN
                CASE i_kbn
                    WHEN 'S'
                    /* POS=1以外指定チェック */
                    THEN
                        IF i_pos != 1 THEN
                            i_cid := NULL
                            /* 企業ID */;
                            i_key_num := NULL
                            /* キー */;
                            i_consumer_id := NULL
                            /* クライアントID */;
                            i_service_name := NULL
                            /* サービス名 */;
                            i_key := NULL
                            /* 秘密鍵 */;
                            o_ins_dt := NULL
                            /* 登録日（YYYYMMDDHHMMSS） */;
                            o_upd_dt := NULL;
                        /* 更新日（YYYYMMDDHHMMSS） */
                        ELSE
                            i_cid := key_rec.cid
                            /* 企業ID */;
                            i_key_num := key_rec.key_num
                            /* キー */;
                            i_consumer_id := key_rec.consumer_id
                            /* クライアントID */;
                            i_service_name := key_rec.service_name
                            /* サービス名 */;
                            i_key := key_rec.key
                            /* 秘密鍵 */;
                            o_ins_dt := key_rec.ins_dt
                            /* 登録日（YYYYMMDDHHMMSS） */;
                            o_upd_dt := key_rec.upd_dt
                            /* 更新日（YYYYMMDDHHMMSS） */;
                            w_cnt := w_cnt + 1;
                            PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20ninsyo.p_oauth_pkg$p_key_updt', CONCAT_WS('', 'cid', ':"', key_rec.cid, '",', 'key_num', ':"', key_rec.key_num, '",', 'consumer_id', ':"', key_rec.consumer_id, '",', 'service_name', ':"', key_rec.service_name, '",', 'key', ':"', key_rec.key, '",', 'ins_dt', ':"', key_rec.ins_dt, '",', 'upd_dt', ':"', key_rec.upd_dt, '"'));
                            o_cnt := 1;
                        END IF;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                    WHEN 'I' THEN
                        w_rtncd := '0003';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, 'クライアントID有りエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    WHEN 'U' THEN
                        UPDATE api20ninsyo.oauth_key_tbl
                        SET consumer_id = i_consumer_id
                        /* 更新用クライアントID */, key_num = i_key_num
                        /* キー */, service_name = i_service_name
                        /* サービス名 */, key = i_key
                        /* 秘密鍵 */, upd_dt = aws_oracle_ext.SYSDATE()
                        /* 更新日（YYYYMMDDHHMMSS） */
                            WHERE CURRENT OF key_cur;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, NULL)
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
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd, NULL)
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    WHEN 'D' THEN
                        DELETE FROM api20ninsyo.oauth_key_tbl
                            WHERE CURRENT OF key_cur
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, NULL)
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
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd, NULL)
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    ELSE
                        w_rtncd := '0099';
                END CASE;
            /* OAUTH_KEY_TBLにCIDが該当しない場合 */
            ELSE
                CASE i_kbn
                    WHEN 'S' THEN
                        w_rtncd := '0002';
                        o_rtncd := w_rtncd;
                    WHEN 'I' THEN
                        OPEN key_unique (i_cid, i_consumer_id);
                        FETCH key_unique INTO key_unique_rec;
                        key_unique$FOUND := FOUND;

                        IF key_unique$FOUND THEN
                            w_rtncd := '0003';
                            o_rtncd := w_rtncd;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, 'クライアントID有りエラー')
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                        /* KEY_NUM自動発番（KEY_NUMがNULLの場合） */
                        ELSE
                            IF i_key_num IS NULL THEN
                                SELECT
                                    COALESCE(MAX(key_num), 0)
                                    INTO STRICT i_key_num
                                    FROM api20ninsyo.oauth_key_tbl
                                    WHERE cid = i_cid;
                                i_key_num := i_key_num + 1;
                            END IF
                            /* 秘密鍵テーブルデータ追加 */;
                            INSERT INTO api20ninsyo.oauth_key_tbl
                            VALUES (i_cid
                            /* 企業ID */, i_key_num
                            /* キー */, i_consumer_id
                            /* クライアントID */, i_service_name
                            /* サービス名 */, i_key
                            /* 秘密鍵 */, aws_oracle_ext.SYSDATE()
                            /* 登録日（YYYYMMDDHHMMSS） */, aws_oracle_ext.SYSDATE()
                            /* 更新日（YYYYMMDDHHMMSS） */)
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                            w_rtncd := '0000';
                            o_rtncd := w_rtncd;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, NULL)
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
                            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd, NULL)
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                        END IF;
                        CLOSE key_unique;
                    WHEN 'U' THEN
                        w_rtncd := '0002';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, '該当データ無しエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    WHEN 'D' THEN
                        w_rtncd := '0002';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, '該当データ無しエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    ELSE
                        w_rtncd := '0099';
                        o_rtncd := w_rtncd;
                END CASE;
            END IF;
            CLOSE key_cur;
        ELSE
            w_rtncd := '0001';
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, '企業ID無しエラー')
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
        END IF;
        CLOSE oauth_corp_cur;
    END IF
    /* テーブル更新ログ書き込み */;
    INSERT INTO api20ninsyo.api20_tbl_updt_log
    VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', NULL, i_kbn, i_uid, i_cid, w_rtncd, '処理完了')
    /*
    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
    commit
    */;
    o_rtncd := w_rtncd;
    o_err_msg := NULL;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20ninsyo.p_oauth_pkg$p_key_updt', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20ninsyo.p_oauth_pkg$p_key_updt');
    EXCEPTION
        WHEN others THEN
            NULL;
            w_rtncd := '7001'
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg          := substrb(SQLERRM,1,200)
            */
            /* テーブル更新ログ書き込み */;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'OAUTH_KEY', NULL, i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, w_msg)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
            o_err_msg := w_msg;
END;
$BODY$
LANGUAGE  plpgsql;