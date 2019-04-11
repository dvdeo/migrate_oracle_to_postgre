CREATE OR REPLACE FUNCTION api20ninsyo.p_fapi20_pkg$p_reg(IN i_uid TEXT, IN i_cid TEXT, OUT o_rtncd TEXT, OUT o_err_msg TEXT)
AS
$BODY$
/* API企業情報取得カーソル(無償版) */
DECLARE
    fapi_corp_cur CURSOR (i_cid TEXT) FOR
    SELECT
        cid, passwd, cname, cname_kana, addr, post, tel, dept, s_date, e_date, sales_id, other_maddr, end_flg, CONCAT_WS('', usage, '::', maddr, '::', hack_flg, '::', note, '::', user_flg, '::', known_trigger) AS usage, name
        FROM api20ninsyo.fapi20_corp_mst
        WHERE cid = i_cid
        FOR UPDATE;
    fapi_corp_rec record
    /* API企業情報取得カーソル(有償版) */;
    api_corp_cur CURSOR (i_cid TEXT) FOR
    SELECT
        cid
        FROM api20ninsyo.api20_corp_mst
        WHERE cid = i_cid;
    api_corp_rec record
    /* ワーク変数 */;
    w_n_rtncd_mail DOUBLE PRECISION
    /* リターンコード(企業マスタ更新用メール送信プロシージャ用) */;
    w_c_rtncd_mail CHARACTER(4)
    /* リターンコード(企業マスタ更新用メール送信プロシージャ用) */;
    w_rtncd CHARACTER(4)
    /* リターンコード */;
    w_msg CHARACTER VARYING(200)
    /* エラーメッセージ */;
    w_proc_rtncd CHARACTER(4);
    fapi_corp_cur$FOUND BOOLEAN DEFAULT false;
    api_corp_cur$FOUND BOOLEAN DEFAULT false;
/* リターンコード */
/* クリア */
BEGIN
    o_rtncd := '0000';
    o_err_msg := NULL;
    w_rtncd := '0000';
    OPEN fapi_corp_cur (i_cid);
    FETCH fapi_corp_cur INTO fapi_corp_rec;
    fapi_corp_cur$FOUND := FOUND;

    IF fapi_corp_cur$FOUND THEN
        OPEN api_corp_cur (i_cid);
        FETCH api_corp_cur INTO api_corp_rec;
        api_corp_cur$FOUND := FOUND;

        IF api_corp_cur$FOUND THEN
            w_rtncd := '0002';
            o_rtncd := w_rtncd;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'REG', 'TABLE', 'I', i_uid, i_cid, w_rtncd, '企業ID有りエラー')
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
        /* API企業マスタ(無償版)からAPI企業マスタ(有償版)へコピー */
        ELSE
            INSERT INTO api20ninsyo.api20_corp_mst (cid
            /* 企業ID */, passwd
            /* パスワード */, cname
            /* 企業名 */, cname_kana
            /* 企業名カナ */, addr
            /* 住所 */, post
            /* 郵便番号 */, tel
            /* 電話番号 */, dept
            /* 部署 */, s_date
            /* サービス開始日付（YYYYMMDDHHMMSS） */, e_date
            /* サービス終了日付（YYYYMMDDHHMMSS） */, sales_id
            /* 担当営業ユーザID */, other_maddr
            /* メールアドレス */, end_flg
            /* 契約終了フラグ（0:利用中、1:終了） */, usage
            /* 用途(用途::メールアドレス::ハッカソン::備考::利用者フラグ::サイトを知ったきっかけ) */, ins_dt
            /* 登録日（YYYYMMDDHHMMSS） */, upd_dt
            /* 更新日（YYYYMMDDHHMMSS） */, name
            /* 氏名 */)
            VALUES (fapi_corp_rec.cid
            /* 企業ID */, fapi_corp_rec.passwd
            /* パスワード */, fapi_corp_rec.cname
            /* 企業名 */, fapi_corp_rec.cname_kana
            /* 企業名カナ */, fapi_corp_rec.addr
            /* 住所 */, fapi_corp_rec.post
            /* 郵便番号 */, fapi_corp_rec.tel
            /* 電話番号 */, fapi_corp_rec.dept
            /* 部署 */, fapi_corp_rec.s_date
            /* サービス開始日付（YYYYMMDDHHMMSS） */, fapi_corp_rec.e_date
            /* サービス終了日付（YYYYMMDDHHMMSS） */, fapi_corp_rec.sales_id
            /* 担当営業ユーザID */, fapi_corp_rec.other_maddr
            /* メールアドレス */, fapi_corp_rec.end_flg
            /* 契約終了フラグ（0:利用中、1:終了） */, fapi_corp_rec.usage
            /* 用途(用途::メールアドレス::ハッカソン::備考::利用者フラグ::サイトを知ったきっかけ) */, aws_oracle_ext.SYSDATE()
            /* 登録日（YYYYMMDDHHMMSS） */, aws_oracle_ext.SYSDATE()
            /* 更新日（YYYYMMDDHHMMSS） */, fapi_corp_rec.name
            /* 氏名 */);
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'MST', 'TABLE', 'I', i_uid, i_cid, w_rtncd, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */
            /* リファラーテーブル(無償版)からリファラーテーブル(有償版)へコピー */;
            INSERT INTO api20ninsyo.api20_referer_tbl
            SELECT
                cid, key_num, referer, service_name, aws_oracle_ext.SYSDATE(), aws_oracle_ext.SYSDATE()
                FROM api20ninsyo.fapi20_referer_tbl
                WHERE cid = i_cid;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'REFERER', 'TABLE', 'I', i_uid, i_cid, w_rtncd, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */
            /*
            -- API企業マスタ(無償版)から削除
            delete from fapi20_corp_mst
            where current of fapi_corp_cur;
            */;
            UPDATE api20ninsyo.fapi20_corp_mst
            SET upd_dt = aws_oracle_ext.SYSDATE()
                WHERE CURRENT OF fapi_corp_cur;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'FMST', 'TABLE', 'U', i_uid, i_cid, w_rtncd, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */
            /*
            -- リファラーテーブル(無償版)から削除
            delete from fapi20_referer_tbl
            where cid = i_cid;
            */;
            UPDATE api20ninsyo.fapi20_referer_tbl
            SET upd_dt = aws_oracle_ext.SYSDATE()
                WHERE cid = i_cid;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'FREFERER', 'TABLE', 'U', i_uid, i_cid, w_rtncd, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            w_rtncd := '0000';
            o_rtncd := w_rtncd;
            SELECT
                *
                FROM api20ninsyo.p_refresh('FAUTH_MVIEW'::TEXT)
                INTO w_proc_rtncd
            /* テーブル更新ログ書き込み */;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'FMST', 'MVIEW', 'I', i_uid, i_cid, w_proc_rtncd, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            SELECT
                *
                FROM api20ninsyo.p_refresh('AUTH_MVIEW'::TEXT)
                INTO w_proc_rtncd
            /* テーブル更新ログ書き込み */;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'MST', 'MVIEW', 'I', i_uid, i_cid, w_proc_rtncd, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */
            /* API企業マスタ更新用メール送信 */;
            SELECT
                *
                FROM api20ninsyo.corp_mst_update_mail(i_cid, 'I'::TEXT, i_uid)
                INTO w_n_rtncd_mail;

            IF w_n_rtncd_mail <> 0 THEN
                IF w_n_rtncd_mail = 1 THEN
                    w_c_rtncd_mail := '0001';
                ELSE
                    w_c_rtncd_mail := '0009';
                END IF;
            ELSE
                w_c_rtncd_mail := '0000';
            END IF
            /* テーブル更新ログ書き込み */;
            INSERT INTO api20ninsyo.api20_tbl_updt_log
            VALUES (aws_oracle_ext.SYSDATE(), 'MST', 'MAIL', 'I', i_uid, i_cid, w_c_rtncd_mail, NULL)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
        END IF;
        CLOSE api_corp_cur;
    ELSE
        w_rtncd := '0001';
        o_rtncd := w_rtncd;
        INSERT INTO api20ninsyo.api20_tbl_updt_log
        VALUES (aws_oracle_ext.SYSDATE(), 'REG', 'TABLE', 'I', i_uid, i_cid, w_rtncd, '企業ID無しエラー')
        /*
        [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
        commit
        */;
    END IF;
    CLOSE fapi_corp_cur
    /* テーブル更新ログ書き込み */;
    INSERT INTO api20ninsyo.api20_tbl_updt_log
    VALUES (aws_oracle_ext.SYSDATE(), 'REG', NULL, 'I', i_uid, i_cid, w_rtncd, '処理完了')
    /*
    [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
    commit
    */;
    o_rtncd := w_rtncd;
    o_err_msg := NULL;
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
            VALUES (aws_oracle_ext.SYSDATE(), 'REG', NULL, 'I', i_uid, i_cid, w_rtncd, w_msg)
            /*
            [5350 - Severity CRITICAL - Unable automatically convert statements that explicitly apply or cancel a transaction. Revise your code to try move transaction control on side of application.]
            commit
            */;
            o_rtncd := w_rtncd;
            o_err_msg := w_msg;
END;
$BODY$
LANGUAGE  plpgsql;
