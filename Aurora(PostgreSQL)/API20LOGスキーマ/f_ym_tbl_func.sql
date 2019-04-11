CREATE OR REPLACE FUNCTION api20log.f_ym_tbl_func(IN i_s_ym TEXT, IN i_e_ym TEXT)
RETURNS api20log.ym_tbl_type
AS
$BODY$
DECLARE
    w_ym_tbl api20log.ym_tbl_type;
    w_cnt DOUBLE PRECISION;
BEGIN
    w_ym_tbl := ARRAY[]::api20log.ym_tbl_type;
    w_cnt := TRUNC((((EXTRACT (EPOCH FROM aws_oracle_ext.TO_DATE(i_e_ym, 'yyyymm') - aws_oracle_ext.TO_DATE(i_s_ym, 'yyyymm')) / 86400)::NUMERIC + 31)::NUMERIC / 30::NUMERIC)::NUMERIC);

    FOR i IN 1..w_cnt LOOP
        w_ym_tbl := aws_oracle_ext.EXTEND(w_ym_tbl, 1);
        w_ym_tbl[i] := aws_oracle_ext.TO_CHAR(aws_oracle_ext.ADD_MONTHS(aws_oracle_ext.TO_DATE(i_s_ym, 'yyyymm'), i - 1), 'yyyymm');
    END LOOP;
    RETURN w_ym_tbl;
END;
$BODY$
LANGUAGE  plpgsql;