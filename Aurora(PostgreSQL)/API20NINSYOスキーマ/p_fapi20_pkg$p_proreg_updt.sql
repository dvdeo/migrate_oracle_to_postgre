CREATE OR REPLACE FUNCTION api20ninsyo.p_fapi20_pkg$p_proreg_updt(IN i_kbn TEXT, INOUT i_id TEXT, INOUT i_maddr TEXT, OUT o_ins_dt TEXT, OUT o_upd_dt TEXT, OUT o_rtncd TEXT, OUT o_err_msg TEXT, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
/* 仮登録テーブルカーソル（検索時使用、部分一致） */
DECLARE
    api_proreg_partial_cur CURSOR (i_id TEXT, i_maddr TEXT) FOR
    SELECT
        id, maddr, aws_oracle_ext.TO_CHAR(ins_dt, 'yyyymmddhh24miss') AS ins_dt, aws_oracle_ext.TO_CHAR(upd_dt, 'yyyymmddhh24miss') AS upd_dt
        FROM api20ninsyo.fapi20_proreg_tbl
        WHERE
        CASE i_id
            WHEN NULL THEN 1
            ELSE aws_oracle_ext.INSTR(id, i_id)
        END != 0 AND
        CASE i_maddr
            WHEN NULL THEN 1
            ELSE aws_oracle_ext.INSTR(maddr, i_maddr)
        END != 0
        FOR UPDATE;
    api_proreg_partial_rec record
    /* 仮登録テーブルカーソル(削除時使用、idの完全一致) */;
    api_proreg_complete_cur CURSOR (i_id TEXT, i_maddr TEXT) FOR
    SELECT
        id, maddr, aws_oracle_ext.TO_CHAR(ins_dt, 'yyyymmddhh24miss') AS ins_dt, aws_oracle_ext.TO_CHAR(upd_dt, 'yyyymmddhh24miss') AS upd_dt
        FROM api20ninsyo.fapi20_proreg_tbl
        WHERE id = i_id AND
        CASE i_maddr
            WHEN NULL THEN 1
            ELSE aws_oracle_ext.INSTR(maddr, i_maddr)
        END != 0
        FOR UPDATE;
    api_proreg_complete_rec record
    /* 仮登録テーブルカーソル（ID確認、追加時使用） */;
    id_cur CURSOR (i_id TEXT) FOR
    SELECT
        maddr
        FROM api20ninsyo.fapi20_proreg_tbl
        WHERE id = i_id;
    id_rec record
    /* 仮登録テーブルカーソル（メアド確認、追加時使用） */;
    maddr_cur CURSOR (i_maddr TEXT) FOR
    SELECT
        maddr
        FROM api20ninsyo.fapi20_proreg_tbl
        WHERE maddr = i_maddr;
    maddr_rec record
    /* ワーク変数 */;
    w_cnt INTEGER
    /* 取得データ件数 */;
    w_rtncd CHARACTER(4)
    /* リターンコード */;
    w_msg CHARACTER VARYING(200)
    /* エラーメッセージ */;
    w_proc_rtncd CHARACTER(4);
    api_proreg_partial_cur$FOUND BOOLEAN DEFAULT false;
    id_cur$FOUND BOOLEAN DEFAULT false;
    api_proreg_complete_cur$FOUND BOOLEAN DEFAULT false;
    maddr_cur$FOUND BOOLEAN DEFAULT false;
/* リターンコード */
/* クリア */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20ninsyo.p_fapi20_pkg$p_proreg_updt');
    o_rtncd := '0000';
    o_err_msg := NULL;
    o_cnt := 0;
    w_cnt := 0;
    w_rtncd := '0000';
    CASE i_kbn
        WHEN 'S' THEN
            OPEN api_proreg_partial_cur (i_id, i_maddr);
            FETCH api_proreg_partial_cur INTO api_proreg_partial_rec;
            api_proreg_partial_cur$FOUND := FOUND;

            IF api_proreg_partial_cur$FOUND THEN
                i_id := api_proreg_partial_rec.id
                /* 企業ID */;
                i_maddr := api_proreg_partial_rec.maddr
                /* キー */;
                o_ins_dt := api_proreg_partial_rec.ins_dt
                /* 登録日（YYYYMMDDHHMMSS） */;
                o_upd_dt := api_proreg_partial_rec.upd_dt
                /* 更新日（YYYYMMDDHHMMSS） */;
                w_cnt := w_cnt + 1;
                PERFORM aws_oracle_ext.array$set_value('o_info[' || w_cnt || ']', 'api20ninsyo.p_fapi20_pkg$p_proreg_updt', CONCAT_WS('', 'id', ':"', api_proreg_partial_rec.id, '",', 'maddr', ':"', api_proreg_partial_rec.maddr, '",', 'ins_dt', ':"', api_proreg_partial_rec.ins_dt, '",', 'upd_dt', ':"', api_proreg_partial_rec.upd_dt, '"'));
                o_cnt := 1;
                w_rtncd := '0000';
            ELSE
                w_rtncd := '0001';
            END IF;
            CLOSE api_proreg_partial_cur;
        WHEN 'I' THEN
            OPEN id_cur (i_id);
            FETCH id_cur INTO id_rec;
            id_cur$FOUND := FOUND;

            IF id_cur$FOUND THEN
                w_rtncd := '0002';
                INSERT INTO api20ninsyo.api20_tbl_updt_log
                VALUES (aws_oracle_ext.SYSDATE(), 'PROREG', 'TABLE', i_kbn, '', CONCAT_WS('', i_id, ' maddr:', i_maddr), w_rtncd, 'ID有りエラー')
                /*
                [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                commit
                */;
            ELSE
                OPEN maddr_cur (i_maddr);
                FETCH maddr_cur INTO maddr_rec;
                maddr_cur$FOUND := FOUND;

                IF maddr_cur$FOUND THEN
                    w_rtncd := '0003';
                    INSERT INTO api20ninsyo.api20_tbl_updt_log
                    VALUES (aws_oracle_ext.SYSDATE(), 'PROREG', 'TABLE', i_kbn, '', CONCAT_WS('', i_id, ' maddr:', i_maddr), w_rtncd, 'メールアドレス有りエラー')
                    /*
                    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                    commit
                    */;
                /* 仮登録テーブルデータ追加 */
                ELSE
                    INSERT INTO api20ninsyo.fapi20_proreg_tbl
                    VALUES (i_id
                    /* ID */, i_maddr
                    /* メールアドレス */, aws_oracle_ext.SYSDATE()
                    /* 登録日（YYYYMMDDHHMMSS） */, aws_oracle_ext.SYSDATE()
                    /* 更新日（YYYYMMDDHHMMSS） */)
                    /*
                    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                    commit
                    */;
                    w_rtncd := '0000';
                    INSERT INTO api20ninsyo.api20_tbl_updt_log
                    VALUES (aws_oracle_ext.SYSDATE(), 'PROREG', 'TABLE', i_kbn, '', CONCAT_WS('', i_id, ' maddr:', i_maddr), w_rtncd, NULL)
                    /*
                    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                    commit
                    */;
                END IF;
                CLOSE maddr_cur;
            END IF;
            CLOSE id_cur;
        WHEN 'D' THEN
            OPEN api_proreg_complete_cur (i_id, i_maddr);
            FETCH api_proreg_complete_cur INTO api_proreg_complete_rec;
            api_proreg_complete_cur$FOUND := FOUND;

            IF api_proreg_complete_cur$FOUND THEN
                DELETE FROM api20ninsyo.fapi20_proreg_tbl
                    WHERE CURRENT OF api_proreg_complete_cur
                /*
                [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                commit
                */;
                w_rtncd := '0000';
                INSERT INTO api20ninsyo.api20_tbl_updt_log
                VALUES (aws_oracle_ext.SYSDATE(), 'PROREG', 'TABLE', i_kbn, '', CONCAT_WS('', i_id, ' maddr:', i_maddr), w_rtncd, NULL)
                /*
                [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                commit
                */;
            ELSE
                w_rtncd := '0001';
                INSERT INTO api20ninsyo.api20_tbl_updt_log
                VALUES (aws_oracle_ext.SYSDATE(), 'PROREG', 'TABLE', i_kbn, '', CONCAT_WS('', i_id, ' maddr:', i_maddr), w_rtncd, '該当データ無しエラー')
                /*
                [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                commit
                */;
            END IF;
            CLOSE api_proreg_complete_cur;
        ELSE
            w_rtncd := '0099';
    END CASE;
    o_rtncd := w_rtncd
    /* テーブル更新ログ書き込み */;
    INSERT INTO api20ninsyo.api20_tbl_updt_log
    VALUES (aws_oracle_ext.SYSDATE(), 'PROREG', NULL, i_kbn, '', i_id, w_rtncd, '処理完了')
    /*
    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
    commit
    */;
    o_rtncd := w_rtncd;
    o_err_msg := NULL;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20ninsyo.p_fapi20_pkg$p_proreg_updt', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20ninsyo.p_fapi20_pkg$p_proreg_updt');
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
            VALUES (aws_oracle_ext.SYSDATE(), 'PROREG', NULL, i_kbn, '', CONCAT_WS('', i_id, ' maddr:', i_maddr), w_rtncd, w_msg)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
            o_err_msg := w_msg;
END;
$BODY$
LANGUAGE  plpgsql;