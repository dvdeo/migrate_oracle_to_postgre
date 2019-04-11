CREATE OR REPLACE FUNCTION api20ninsyo.p_refresh(IN i_mview TEXT, OUT rtncd TEXT)
AS
$BODY$
DECLARE
    pubdb_cur CURSOR FOR
    SELECT
        db_link
        FROM api20ninsyo.pubdb_tbl
        WHERE deliver_flg = 1
        ORDER BY db_link
    /* ワーク変数 */;
    w_rtncd CHARACTER(4);
    exec_sql CHARACTER VARYING(100);
    mail_to CHARACTER VARYING(100);
    mail_from CHARACTER VARYING(100);
    mail_msg CHARACTER VARYING(1000);
BEGIN
    w_rtncd := '0000';

    FOR pubdb_rec IN pubdb_cur LOOP
        BEGIN
            exec_sql := CONCAT_WS('', 'begin dbms_mview.refresh@', pubdb_rec.db_link, '(''', i_mview, '''); end;')
            /*
            [9996 - Severity CRITICAL - Transformer error occurred. Please submit report to developers., 5334 - Severity CRITICAL - Unable to convert statements with dynamic SQL statement. Please perform a manual conversion.]
            execute immediate exec_sql
            */;
            EXCEPTION
                WHEN others THEN
                    SELECT
                        to_maddr, from_maddr
                        INTO STRICT mail_to, mail_from
                        FROM api20ninsyo.mail_addr_tbl
                        WHERE kubun = 'DB'
                    /* メール文章作成 */;
                    mail_msg := '';
                    mail_msg := CONCAT_WS('', mail_msg, '-- マテリアライズド・ビュー リフレッシュ処理エラー通知メール --', CHR(10));
                    mail_msg := CONCAT_WS('', mail_msg, CHR(10));
                    mail_msg := CONCAT_WS('', mail_msg, 'ビュー名称：', i_mview, CHR(10));
                    mail_msg := CONCAT_WS('', mail_msg, 'ターゲット：', pubdb_rec.db_link, CHR(10));
                    mail_msg := CONCAT_WS('', mail_msg, 'エラー内容：', aws_oracle_ext.substr(SQLERRM, 1, 200), CHR(10));
                    mail_msg := CONCAT_WS('', mail_msg, CHR(10));
                    mail_msg := CONCAT_WS('', mail_msg, '-----------------------------------------------------', CHR(10));
                    mail_msg := CONCAT_WS('', mail_msg, 'マテリアライズド・ビュー リフレッシュ処理プロシージャ', CHR(10))
                    /* メール送信 */;
                    SELECT
                        *
                        FROM api20ninsyo.mail_sender(i_from := mail_from, i_to := mail_to, i_subject := 'マテリアライズド・ビュー リフレッシュ処理エラー'::TEXT, i_message := mail_msg)
                        INTO rtncd;
                    w_rtncd := '0099';
        END;
    END LOOP;
    rtncd := w_rtncd;
    EXCEPTION
        WHEN others THEN
            SELECT
                to_maddr, from_maddr
                INTO STRICT mail_to, mail_from
                FROM api20ninsyo.mail_addr_tbl
                WHERE kubun = 'DB'
            /* メール文章作成 */;
            mail_msg := '';
            mail_msg := CONCAT_WS('', mail_msg, '-- マテリアライズド・ビュー リフレッシュ処理エラー通知メール --', CHR(10));
            mail_msg := CONCAT_WS('', mail_msg, CHR(10));
            mail_msg := CONCAT_WS('', mail_msg, 'ビュー名称：', i_mview, CHR(10));
            mail_msg := CONCAT_WS('', mail_msg, 'エラー内容：', aws_oracle_ext.substr(SQLERRM, 1, 200), CHR(10));
            mail_msg := CONCAT_WS('', mail_msg, CHR(10));
            mail_msg := CONCAT_WS('', mail_msg, '-----------------------------------------------------', CHR(10));
            mail_msg := CONCAT_WS('', mail_msg, 'マテリアライズド・ビュー リフレッシュ処理プロシージャ', CHR(10))
            /* メール送信 */;
            SELECT
                *
                FROM api20ninsyo.mail_sender(i_from := mail_from, i_to := mail_to, i_subject := 'マテリアライズド・ビュー リフレッシュ処理エラー'::TEXT, i_message := mail_msg)
                INTO rtncd;
            rtncd := '0099';
END;
$BODY$
LANGUAGE  plpgsql;