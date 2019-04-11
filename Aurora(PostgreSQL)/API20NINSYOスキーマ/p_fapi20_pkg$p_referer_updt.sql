CREATE OR REPLACE FUNCTION api20ninsyo.p_fapi20_pkg$p_referer_updt(IN i_kbn TEXT, IN i_uid TEXT, INOUT i_cid TEXT, INOUT i_key_num DOUBLE PRECISION, INOUT i_referer TEXT, INOUT i_service_name TEXT, IN i_pos DOUBLE PRECISION, IN i_cnt DOUBLE PRECISION, OUT o_ins_dt TEXT, OUT o_upd_dt TEXT, OUT o_rtncd TEXT, OUT o_err_msg TEXT, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* リファラーテーブルカーソル（複数件検索用） */
DECLARE
    rf_search CURSOR (i_cid TEXT, i_referer TEXT, i_service_name TEXT, i_pos DOUBLE PRECISION, i_cnt DOUBLE PRECISION) FOR
    SELECT
        *
        FROM (SELECT
            cid, key_num, referer, service_name, aws_oracle_ext.TO_CHAR(ins_dt, 'yyyymmddhh24miss') AS ins_dt, aws_oracle_ext.TO_CHAR(upd_dt, 'yyyymmddhh24miss') AS upd_dt, all_cnt, ROW_NUMBER() OVER (ORDER BY cid, key_num) AS rnum
            FROM (SELECT
                cid, key_num, referer, service_name, ins_dt, upd_dt, COUNT(*) OVER () AS all_cnt
                FROM api20ninsyo.fapi20_referer_tbl
                WHERE
                CASE i_cid
                    WHEN NULL THEN 1
                    ELSE aws_oracle_ext.INSTR(cid, i_cid)
                END != 0 AND
                CASE i_referer
                    WHEN NULL THEN 1
                    ELSE aws_oracle_ext.INSTR(referer, i_referer)
                END != 0 AND
                CASE i_service_name
                    WHEN NULL THEN 1
                    ELSE aws_oracle_ext.INSTR(service_name, i_service_name)
                END != 0) AS var_sbq) AS var_sbq_2
        WHERE rnum BETWEEN i_pos AND (i_pos + i_cnt - 1)
        ORDER BY rnum
    /* リファラーテーブルカーソル（更新時企業ID確認） */;
    rf_cur CURSOR (i_cid TEXT, i_key_num DOUBLE PRECISION) FOR
    SELECT
        cid, key_num, referer, service_name, aws_oracle_ext.TO_CHAR(ins_dt, 'yyyymmddhh24miss') AS ins_dt, aws_oracle_ext.TO_CHAR(upd_dt, 'yyyymmddhh24miss') AS upd_dt
        FROM api20ninsyo.fapi20_referer_tbl
        WHERE cid = i_cid AND key_num = i_key_num
        FOR UPDATE;
    rf_rec record
    /* リファラーテーブルカーソル（登録時リファラー確認） */;
    rf_unique CURSOR (i_cid TEXT, i_referer TEXT) FOR
    SELECT
        cid, referer
        FROM api20ninsyo.fapi20_referer_tbl
        WHERE cid = i_cid AND referer = i_referer;
    rf_unique_rec record
    /* API企業マスタカーソル */;
    api_corp_cur CURSOR (i_cid TEXT) FOR
    SELECT
        cid, s_date, e_date
        FROM api20ninsyo.fapi20_corp_mst
        WHERE cid = i_cid;
    api_corp_rec record
    /* ワーク変数 */;
    w_cnt INTEGER
    /* 取得データ件数 */;
    w_rtncd CHARACTER(4)
    /* リターンコード */;
    w_msg CHARACTER VARYING(200)
    /* エラーメッセージ */;
    w_proc_rtncd CHARACTER(4);
    api_corp_cur$FOUND BOOLEAN DEFAULT false;
    rf_cur$FOUND BOOLEAN DEFAULT false;
    rf_unique$FOUND BOOLEAN DEFAULT false;
/* リターンコード */
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20ninsyo.p_fapi20_pkg$p_referer_updt');
    o_rtncd := '0000';
    o_err_msg := NULL;
    o_cnt := 0;
    w_cnt := 0;
    w_rtncd := '0000'
    /* 複数件指定処理 */;

    IF i_kbn = 'S' AND i_key_num IS NULL THEN
        FOR rf_srch_rec IN rf_search (i_cid, i_referer, i_service_name, i_pos, i_cnt) LOOP
            w_cnt := w_cnt + 1;
            PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20ninsyo.p_fapi20_pkg$p_referer_updt', CONCAT_WS('', 'cid', ':"', rf_srch_rec.cid, '",', 'key_num', ':"', rf_srch_rec.key_num, '",', 'referer', ':"', rf_srch_rec.referer, '",', 'service_name', ':"', rf_srch_rec.service_name, '",', 'ins_dt', ':"', rf_srch_rec.ins_dt, '",', 'upd_dt', ':"', rf_srch_rec.upd_dt, '"'));
            o_cnt := rf_srch_rec.all_cnt;
        END LOOP;
        o_rtncd := '0000';
    /* 正常終了 */
    /* １REFERER指定処理 */
    ELSE
        OPEN api_corp_cur (i_cid)
        /* FAPI20_CORP_MSTに企業IDがあるかどうか */;
        FETCH api_corp_cur INTO api_corp_rec;
        api_corp_cur$FOUND := FOUND;

        IF api_corp_cur$FOUND THEN
            OPEN rf_cur (i_cid, i_key_num)
            /* FAPI20_REFERER_TBLにCIDとKEY_NUMがあるかどうか */;
            FETCH rf_cur INTO rf_rec;
            rf_cur$FOUND := FOUND;

            IF rf_cur$FOUND
            /* FAPI20_REFERER_TBLにCIDが該当する場合 */
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
                            i_referer := NULL
                            /* リファラー */;
                            i_service_name := NULL
                            /* サービス名 */;
                            o_ins_dt := NULL
                            /* 登録日（YYYYMMDDHHMMSS） */;
                            o_upd_dt := NULL;
                        /* 更新日（YYYYMMDDHHMMSS） */
                        ELSE
                            i_cid := rf_rec.cid
                            /* 企業ID */;
                            i_key_num := rf_rec.key_num
                            /* キー */;
                            i_referer := rf_rec.referer
                            /* リファラー */;
                            i_service_name := rf_rec.service_name
                            /* サービス名 */;
                            o_ins_dt := rf_rec.ins_dt
                            /* 登録日（YYYYMMDDHHMMSS） */;
                            o_upd_dt := rf_rec.upd_dt
                            /* 更新日（YYYYMMDDHHMMSS） */;
                            w_cnt := w_cnt + 1;
                            PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20ninsyo.p_fapi20_pkg$p_referer_updt', CONCAT_WS('', 'cid', ':"', rf_rec.cid, '",', 'key_num', ':"', rf_rec.key_num, '",', 'referer', ':"', rf_rec.referer, '",', 'service_name', ':"', rf_rec.service_name, '",', 'ins_dt', ':"', rf_rec.ins_dt, '",', 'upd_dt', ':"', rf_rec.upd_dt, '"'));
                            o_cnt := 1;
                        END IF;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                    WHEN 'I' THEN
                        w_rtncd := '0003';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, 'リファラー有りエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    WHEN 'U'
                    /* APIキーテーブルデータ更新 */
                    THEN
                        UPDATE api20ninsyo.fapi20_referer_tbl
                        SET referer = i_referer
                        /* 更新用リファラー */, key_num = i_key_num
                        /* キー */, service_name = i_service_name
                        /* サービス名 */, upd_dt = aws_oracle_ext.SYSDATE()
                        /* 更新日（YYYYMMDDHHMMSS） */
                            WHERE CURRENT OF rf_cur;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, NULL)
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                        SELECT
                            *
                            FROM api20ninsyo.p_refresh('FAUTH_MVIEW'::TEXT)
                            INTO w_proc_rtncd
                        /* テーブル更新ログ書き込み */;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd, NULL)
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    WHEN 'D'
                    /* APIキーテーブルデータ削除 */
                    THEN
                        DELETE FROM api20ninsyo.fapi20_referer_tbl
                            WHERE CURRENT OF rf_cur
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                        w_rtncd := '0000';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, NULL)
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                        SELECT
                            *
                            FROM api20ninsyo.p_refresh('FAUTH_MVIEW'::TEXT)
                            INTO w_proc_rtncd
                        /* テーブル更新ログ書き込み */;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd, NULL)
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    ELSE
                        w_rtncd := '0099';
                END CASE;
            /* FAPI20_REFERER_TBLにCIDが該当しない場合 */
            ELSE
                CASE i_kbn
                    WHEN 'S' THEN
                        w_rtncd := '0002';
                        o_rtncd := w_rtncd;
                    WHEN 'I' THEN
                        OPEN rf_unique (i_cid, i_referer);
                        FETCH rf_unique INTO rf_unique_rec;
                        rf_unique$FOUND := FOUND;

                        IF rf_unique$FOUND THEN
                            w_rtncd := '0003';
                            o_rtncd := w_rtncd;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, 'リファラー有りエラー')
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
                                    FROM api20ninsyo.fapi20_referer_tbl
                                    WHERE cid = i_cid;
                                i_key_num := i_key_num + 1;
                            END IF
                            /* リファラーテーブルデータ追加 */;
                            INSERT INTO api20ninsyo.fapi20_referer_tbl
                            VALUES (i_cid
                            /* 企業ID */, i_key_num
                            /* キー */, i_referer
                            /* リファラー */, i_service_name
                            /* サービス名 */, aws_oracle_ext.SYSDATE()
                            /* 登録日（YYYYMMDDHHMMSS） */, aws_oracle_ext.SYSDATE()
                            /* 更新日（YYYYMMDDHHMMSS） */)
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                            w_rtncd := '0000';
                            o_rtncd := w_rtncd;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, NULL)
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                            SELECT
                                *
                                FROM api20ninsyo.p_refresh('FAUTH_MVIEW'::TEXT)
                                INTO w_proc_rtncd
                            /* テーブル更新ログ書き込み */;
                            INSERT INTO api20ninsyo.api20_tbl_updt_log
                            VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'MVIEW', i_kbn, i_uid, i_cid, w_proc_rtncd, NULL)
                            /*
                            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                            commit
                            */;
                        END IF;
                        CLOSE rf_unique;
                    WHEN 'U' THEN
                        w_rtncd := '0002';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, '該当データ無しエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    WHEN 'D' THEN
                        w_rtncd := '0002';
                        o_rtncd := w_rtncd;
                        INSERT INTO api20ninsyo.api20_tbl_updt_log
                        VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, '該当データ無しエラー')
                        /*
                        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                        commit
                        */;
                    ELSE
                        w_rtncd := '0099';
                        o_rtncd := w_rtncd;
                END CASE;
            END IF;
            CLOSE rf_cur;
        ELSE
            w_rtncd := '0001';
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, '企業ID無しエラー')
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
        END IF;
        CLOSE api_corp_cur;
    END IF
    /* テーブル更新ログ書き込み */;
    INSERT INTO api20ninsyo.api20_tbl_updt_log
    VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', NULL, i_kbn, i_uid, i_cid, w_rtncd, '処理完了')
    /*
    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
    commit
    */;
    o_rtncd := w_rtncd;
    o_err_msg := NULL;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20ninsyo.p_fapi20_pkg$p_referer_updt', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20ninsyo.p_fapi20_pkg$p_referer_updt');
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
            VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', NULL, i_kbn, i_uid, CONCAT_WS('', i_cid, ' key_num:', aws_oracle_ext.TO_CHAR(i_key_num)), w_rtncd, w_msg)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
            o_err_msg := w_msg;
END;
$BODY$
LANGUAGE  plpgsql;