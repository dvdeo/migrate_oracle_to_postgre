CREATE OR REPLACE FUNCTION api20ninsyo.p_smartphone_mst_get(IN i_ua TEXT, OUT o_info api20ninsyo.typ_ret_to_php, OUT o_rtncd TEXT)
AS
$BODY$
DECLARE
    sp_mst_cur CURSOR (i_ua TEXT) FOR
    SELECT
        id, CONCAT_WS('', api20ninsyo.f_chg_column('nm'::TEXT), ':"', nm, '",'
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
        /* 住宅地図アプリ種別識別フラグ */, api20ninsyo.f_chg_column('col_11'::TEXT), ':"', COALESCE(col_11, ''), '"') AS sp_info
        FROM api20ninsyo.sp_mst
        WHERE id = i_ua AND valid_flg = '1';
    sp_mst_rec record
    /* 出力項目変数 */;
    rtncd CHARACTER(5)
    /* リターンコード */
    /* 変数 */;
    w_index DOUBLE PRECISION := 0;
    sp_mst_cur$FOUND BOOLEAN DEFAULT false;
/* 初期化 */
BEGIN
    o_info := ARRAY[]::api20ninsyo.typ_ret_to_php;
    rtncd := '00000';
    OPEN sp_mst_cur (i_ua);
    FETCH sp_mst_cur INTO sp_mst_rec;
    sp_mst_cur$FOUND := FOUND;

    IF (NOT sp_mst_cur$FOUND) THEN
        rtncd := '12001';
    ELSE
        o_info := aws_oracle_ext.EXTEND(o_info);
        w_index := array_upper(o_info, 1);
        o_info[w_index] := sp_mst_rec.sp_info;
    END IF;
    CLOSE sp_mst_cur;
    o_rtncd := rtncd;
    EXCEPTION
        WHEN others THEN
            o_rtncd := '17003';
END;
$BODY$
LANGUAGE  plpgsql;