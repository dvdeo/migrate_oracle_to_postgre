CREATE OR REPLACE FUNCTION api20ninsyo.f_chg_column(IN i_column TEXT, IN i_kbn TEXT DEFAULT 0)
RETURNS TEXT
AS
$BODY$
DECLARE
    cur_col2name CURSOR (i_column TEXT) FOR
    SELECT
        name
        FROM api20ninsyo.sp_mst_def
        WHERE LOWER(col_name) = LOWER(i_column);
    cur_name2col CURSOR (i_column TEXT) FOR
    SELECT
        col_name
        FROM api20ninsyo.sp_mst_def
        WHERE LOWER(name) = LOWER(i_column);
    w_column CHARACTER VARYING(30000);
    cur_col2name$FOUND BOOLEAN DEFAULT false;
    cur_name2col$FOUND BOOLEAN DEFAULT false;
BEGIN
    IF i_column IS NOT NULL THEN
        w_column := NULL;

        IF i_kbn = 0::TEXT THEN
            OPEN cur_col2name (i_column);
            FETCH cur_col2name INTO w_column;
            cur_col2name$FOUND := FOUND;

            IF (NOT cur_col2name$FOUND) THEN
                w_column := NULL;
            END IF;
            CLOSE cur_col2name;
        ELSE
            OPEN cur_name2col (i_column);
            FETCH cur_name2col INTO w_column;
            cur_name2col$FOUND := FOUND;

            IF (NOT cur_name2col$FOUND) THEN
                w_column := NULL;
            END IF;
            CLOSE cur_name2col;
        END IF;
    END IF;
    RETURN w_column;
    EXCEPTION
        WHEN others THEN
            RETURN NULL;
END;
$BODY$
LANGUAGE  plpgsql;