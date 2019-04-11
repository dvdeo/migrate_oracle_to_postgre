CREATE OR REPLACE FUNCTION api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd(IN i_kbn TEXT, IN i_uid TEXT, IN i_ua TEXT, IN i_val VARCHAR, IN i_val$function_name VARCHAR, OUT o_rtncd TEXT, OUT o_err_msg TEXT, OUT o_cnt DOUBLE PRECISION, IN o_info VARCHAR, IN o_info$function_name VARCHAR)
AS
$BODY$
DECLARE
    sp_mst_search_cur CURSOR (i_ua TEXT) FOR
    SELECT
        CONCAT_WS('', 'id', ':"', id, '",'
        /* ID */, api20ninsyo.f_chg_column('nm'::TEXT), ':"', nm, '",'
        /* 名称 */, api20ninsyo.f_chg_column('col_01'::TEXT), ':"', COALESCE(col_01, '000'), '",'
        /* キャリア */, api20ninsyo.f_chg_column('col_02'::TEXT), ':"', COALESCE(col_02, '0'), '",'
        /* 地図表示サイズ(縦) */, api20ninsyo.f_chg_column('col_03'::TEXT), ':"', COALESCE(col_03, '0'), '",'
        /* 地図表示サイズ(横) */, api20ninsyo.f_chg_column('col_04'::TEXT), ':"', COALESCE(col_04, '0'), '",'
        /* px(縦) */, api20ninsyo.f_chg_column('col_05'::TEXT), ':"', COALESCE(col_05, '0'), '",'
        /* px(横) */, api20ninsyo.f_chg_column('col_06'::TEXT), ':"', COALESCE(col_06, '0'), '",'
        /* dp(縦) */, api20ninsyo.f_chg_column('col_07'::TEXT), ':"', COALESCE(col_07, '0'), '",'
        /* dp(横) */, api20ninsyo.f_chg_column('col_08'::TEXT), ':"', COALESCE(col_08, '000'), '",'
        /* ピクセル密度 */, api20ninsyo.f_chg_column('col_09'::TEXT), ':"', COALESCE(col_09, '0'), '",'
        /* dpi */, api20ninsyo.f_chg_column('col_10'::TEXT), ':"', COALESCE(col_10, '0'), '",'
        /* density */, api20ninsyo.f_chg_column('flg_01'::TEXT), ':"', COALESCE(flg_01, '0'), '",'
        /* 地図・ご当地アプリ対応フラグ */, api20ninsyo.f_chg_column('flg_02'::TEXT), ':"', COALESCE(flg_02, '0'), '",'
        /* ウィジェットアプリ対応フラグ */, api20ninsyo.f_chg_column('flg_03'::TEXT), ':"', COALESCE(flg_03, 'N'), '",'
        /* 地図・ご当地アプリのマーケット遷移先 */, api20ninsyo.f_chg_column('flg_04'::TEXT), ':"', COALESCE(flg_04, 'N'), '",'
        /* ウィジェットアプリのマーケット遷移先 */, api20ninsyo.f_chg_column('flg_05'::TEXT), ':"', COALESCE(flg_05, ''), '",'
        /* アプリ種別識別フラグ */, api20ninsyo.f_chg_column('flg_06'::TEXT), ':"', COALESCE(flg_06, '0'), '",'
        /* 住宅地図(運輸)フラグ */, api20ninsyo.f_chg_column('flg_07'::TEXT), ':"', COALESCE(flg_07, '0'), '",'
        /* 住宅地図(建築)フラグ */, api20ninsyo.f_chg_column('flg_10'::TEXT), ':"', COALESCE(flg_10, '0'), '",'
        /* 住宅地図(ゼンリン)フラグ */, api20ninsyo.f_chg_column('flg_08'::TEXT), ':"', COALESCE(flg_08, '0'), '",'
        /* 海外アプリ対応フラグ */, api20ninsyo.f_chg_column('flg_09'::TEXT), ':"', COALESCE(flg_09, '0'), '",'
        /* 電話可否フラグ */, api20ninsyo.f_chg_column('flg_11'::TEXT), ':"', COALESCE(flg_11, '0'), '",'
        /* ドコモ地図ナビ自律航法対応フラグ */, api20ninsyo.f_chg_column('flg_12'::TEXT), ':"', COALESCE(flg_12, '0'), '",'
        /* 住宅地図アプリ種別識別フラグ */, api20ninsyo.f_chg_column('col_11'::TEXT), ':"', COALESCE(col_11, ''), '",'
        /* スゴ得アプリ対象バージョン */, 'valid_flg:"', COALESCE(valid_flg, '0'), '"') AS sp_info
        FROM api20ninsyo.sp_mst
        WHERE
        CASE i_ua
            WHEN NULL THEN 1
            ELSE aws_oracle_ext.INSTR(id, i_ua)
        END != 0;
    sp_mst_search_rec record;
    sp_mst_cur CURSOR (i_ua TEXT) FOR
    SELECT
        id
        FROM api20ninsyo.sp_mst
        WHERE id = i_ua
        FOR UPDATE;
    sp_mst_rec record
    /* 変数 */;
    w_index DOUBLE PRECISION := 0;
    w_rtncd CHARACTER(4)
    /* リターンコード */;
    w_proc_rtncd CHARACTER(4)
    /* リターンコード */;
    w_msg CHARACTER VARYING(200)
    /* エラーメッセージ */;
    w_val_tbl api20ninsyo.func_split_type;
    w_sql CHARACTER VARYING(4000);
    w_col CHARACTER VARYING(4000)
    /* insert/update文列名 */;
    w_val CHARACTER VARYING(4000)
    /* insert/update文値 */;
    c1 NUMERIC(38) := 0;
    nrtnexecute DOUBLE PRECISION;
    sp_mst_cur$FOUND BOOLEAN DEFAULT false;
/* sql戻り値 */
/* 初期化 */
BEGIN
    PERFORM aws_oracle_ext.array$copy_structure(o_info, o_info$function_name, 'o_info', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd');
    PERFORM aws_oracle_ext.array$copy(i_val, i_val$function_name, 'i_val', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd');
    w_rtncd := '0000';
    o_rtncd := '0000';
    o_err_msg := NULL;
    o_cnt := 0;

    IF i_kbn = 'S' THEN
        FOR sp_mst_search_rec IN sp_mst_search_cur (i_ua) LOOP
            w_index := w_index + 1;
            PERFORM aws_oracle_ext.array$set_value('o_info[' || w_index || ']', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd', sp_mst_search_rec.sp_info);
        END LOOP;
        o_cnt := aws_oracle_ext.array$count('o_info', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd');
    ELSE
        OPEN sp_mst_cur (i_ua);
        FETCH sp_mst_cur INTO sp_mst_rec;
        sp_mst_cur$FOUND := FOUND;

        IF sp_mst_cur$FOUND THEN
            CASE i_kbn
                WHEN 'I' THEN
                    w_rtncd := '0001'
                    /* テーブル更新ログ書き込み */;
                    INSERT INTO api20ninsyo.api20_tbl_updt_log
                    VALUES (aws_oracle_ext.SYSDATE(), 'SP_MST', 'TABLE', i_kbn, i_uid, CONCAT_WS('', 'UA:', i_ua), w_rtncd, 'UA有りエラー')
                    /*
                    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                    commit
                    */;
                WHEN 'U' THEN
                    FOR i IN aws_oracle_ext.array$first('i_val', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd', NULL::BIGINT)..aws_oracle_ext.array$last('i_val', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd', NULL::BIGINT) LOOP
                        w_val_tbl := api20ninsyo.func_split(aws_oracle_ext.array$get_value('i_val[' || i || ']', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd', NULL::CHARACTER VARYING(4000)), ':'::TEXT);

                        IF COALESCE(array_length(w_val_tbl, 1), 0) = 1 THEN
                            w_val := CONCAT_WS('', w_val, api20ninsyo.f_chg_column(w_val_tbl[1], '1'::TEXT), '=null,');
                        ELSE
                            w_val := CONCAT_WS('', w_val, api20ninsyo.f_chg_column(w_val_tbl[1], '1'::TEXT), '=''', w_val_tbl[2], ''',');
                        END IF;
                    END LOOP;
                    w_sql := CONCAT_WS('', 'update sp_mst set ', w_val, 'UPD_DT = sysdate ');
                    w_sql := CONCAT_WS('', w_sql, 'where id =''', i_ua, '''')
                    /* dbms_output.put_line('UPDSQL=' || w_sql); */
                    /* CURSORのオープン */;
                    c1 := aws_oracle_ext.dbms_sql$open_cursor()
                    /* sql文の解析 */
                    /*
                    [5334 - Severity CRITICAL - Unable to convert statements with dynamic SQL statement. Please perform a manual conversion.]
                    dbms_sql.parse(c1 , w_sql , dbms_sql.native)
                    */
                    /* sql実行 */;
                    nrtnexecute := aws_oracle_ext.dbms_sql$execute((c1)::INTEGER)
                    /* cursorのクローズ */;
                    c1 := aws_oracle_ext.dbms_sql$close_cursor((c1)::NUMERIC)
                    /*
                    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                    commit
                    */;
                    w_rtncd := '0000';
                WHEN 'D' THEN
                    DELETE FROM api20ninsyo.sp_mst
                        WHERE CURRENT OF sp_mst_cur;
                    w_rtncd := '0000';
                ELSE
                    w_rtncd := '0099';
            END CASE;
        ELSE
            CASE i_kbn
                WHEN 'I' THEN
                    FOR i IN aws_oracle_ext.array$first('i_val', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd', NULL::BIGINT)..aws_oracle_ext.array$last('i_val', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd', NULL::BIGINT) LOOP
                        w_val_tbl := api20ninsyo.func_split(aws_oracle_ext.array$get_value('i_val[' || i || ']', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd', NULL::CHARACTER VARYING(4000)), ':'::TEXT);
                        w_col := CONCAT_WS('', w_col, api20ninsyo.f_chg_column(w_val_tbl[1], '1'::TEXT), ',');

                        IF COALESCE(array_length(w_val_tbl, 1), 0) = 1 THEN
                            w_val := CONCAT_WS('', w_val, 'null,');
                        ELSE
                            w_val := CONCAT_WS('', w_val, '''', w_val_tbl[2], ''',');
                        END IF;
                    END LOOP;
                    w_sql := CONCAT_WS('', 'insert into sp_mst (ID,', w_col, 'INS_DT,UPD_DT) ');
                    w_sql := CONCAT_WS('', w_sql, 'values(');
                    w_sql := CONCAT_WS('', w_sql, '''', i_ua, ''',');
                    w_sql := CONCAT_WS('', w_sql, w_val, 'sysdate,sysdate)')
                    /* dbms_output.put_line('INSSQL=' || w_sql); */
                    /* CURSORのオープン */;
                    c1 := aws_oracle_ext.dbms_sql$open_cursor()
                    /* sql文の解析 */
                    /*
                    [5334 - Severity CRITICAL - Unable to convert statements with dynamic SQL statement. Please perform a manual conversion.]
                    dbms_sql.parse(c1 , w_sql , dbms_sql.native)
                    */
                    /* sql実行 */;
                    nrtnexecute := aws_oracle_ext.dbms_sql$execute((c1)::INTEGER)
                    /* cursorのクローズ */;
                    c1 := aws_oracle_ext.dbms_sql$close_cursor((c1)::NUMERIC)
                    /*
                    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                    commit
                    */;
                    w_rtncd := '0000';
                WHEN 'U' THEN
                    w_rtncd := '0002'
                    /* テーブル更新ログ書き込み */;
                    INSERT INTO api20ninsyo.api20_tbl_updt_log
                    VALUES (aws_oracle_ext.SYSDATE(), 'SP_MST', 'TABLE', i_kbn, i_uid, CONCAT_WS('', 'UA:', i_ua), w_rtncd, 'UA無しエラー')
                    /*
                    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                    commit
                    */;
                WHEN 'D' THEN
                    w_rtncd := '0002'
                    /* テーブル更新ログ書き込み */;
                    INSERT INTO api20ninsyo.api20_tbl_updt_log
                    VALUES (aws_oracle_ext.SYSDATE(), 'SP_MST', 'TABLE', i_kbn, i_uid, CONCAT_WS('', 'UA:', i_ua), w_rtncd, 'UA無しエラー')
                    /*
                    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
                    commit
                    */;
                ELSE
                    w_rtncd := '0099';
            END CASE;
        END IF;
        CLOSE sp_mst_cur
        /* 正常更新した場合は公開DBへREFRESH */;

        IF w_rtncd = '0000'
        /* テーブル更新ログ書き込み */
        THEN
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'SP_MST', NULL, i_kbn, i_uid, CONCAT_WS('', 'UA:', i_ua), w_rtncd, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            SELECT
                *
                FROM api20ninsyo.p_refresh('SP_MST'::TEXT)
                INTO w_proc_rtncd
            /* テーブル更新ログ書き込み */;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'SP_MST', 'MVIEW', i_kbn, i_uid, CONCAT_WS('', 'UA:', i_ua), w_proc_rtncd, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
        END IF;
    END IF;
    o_rtncd := w_rtncd;
    o_err_msg := NULL;
    PERFORM aws_oracle_ext.array$assign('o_info', 'api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd', o_info, o_info$function_name);
    PERFORM aws_oracle_ext.array$clear_procedure('api20ninsyo.p_smartphone_mst_pkg$p_smartphone_mst_upd');
    EXCEPTION
        WHEN others THEN
            NULL;
            w_rtncd := '7001'
            /*
            [5340 - Severity CRITICAL - PostgreSQL doesn't support the STANDARD.SUBSTRB(VARCHAR2,PLS_INTEGER,PLS_INTEGER) function. Use suitable function or create user defined function.]
            w_msg    := substrb(SQLERRM,1,200)
            */
            /* テーブル更新ログ書き込み */;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'SP_MST', NULL, i_kbn, i_uid, CONCAT_WS('', 'UA:', i_ua), w_rtncd, w_msg)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
            o_err_msg := w_msg;
END;
$BODY$
LANGUAGE  plpgsql;