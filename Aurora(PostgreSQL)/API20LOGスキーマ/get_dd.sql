CREATE OR REPLACE FUNCTION api20log.get_dd(IN i_ym TEXT, IN i_dd01 TEXT, IN i_dd02 TEXT, IN i_dd03 TEXT, IN i_dd04 TEXT, IN i_dd05 TEXT, IN i_dd06 TEXT, IN i_dd07 TEXT, IN i_dd08 TEXT, IN i_dd09 TEXT, IN i_dd10 TEXT, IN i_dd11 TEXT, IN i_dd12 TEXT, IN i_dd13 TEXT, IN i_dd14 TEXT, IN i_dd15 TEXT, IN i_dd16 TEXT, IN i_dd17 TEXT, IN i_dd18 TEXT, IN i_dd19 TEXT, IN i_dd20 TEXT, IN i_dd21 TEXT, IN i_dd22 TEXT, IN i_dd23 TEXT, IN i_dd24 TEXT, IN i_dd25 TEXT, IN i_dd26 TEXT, IN i_dd27 TEXT, IN i_dd28 TEXT, IN i_dd29 TEXT, IN i_dd30 TEXT, IN i_dd31 TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    w_out CHARACTER VARYING(4000);
    w_dd NUMERIC(2);
BEGIN
    w_dd := aws_oracle_ext.TO_NUMBER(aws_oracle_ext.TO_CHAR(aws_oracle_ext.LAST_DAY(aws_oracle_ext.TO_DATE(i_ym, 'YYYYMM')), 'dd'));
    w_out := NULL;
    w_out := CONCAT_WS('', w_out, 'dd01', ':"', i_dd01, '",');
    w_out := CONCAT_WS('', w_out, 'dd02', ':"', i_dd02, '",');
    w_out := CONCAT_WS('', w_out, 'dd03', ':"', i_dd03, '",');
    w_out := CONCAT_WS('', w_out, 'dd04', ':"', i_dd04, '",');
    w_out := CONCAT_WS('', w_out, 'dd05', ':"', i_dd05, '",');
    w_out := CONCAT_WS('', w_out, 'dd06', ':"', i_dd06, '",');
    w_out := CONCAT_WS('', w_out, 'dd07', ':"', i_dd07, '",');
    w_out := CONCAT_WS('', w_out, 'dd08', ':"', i_dd08, '",');
    w_out := CONCAT_WS('', w_out, 'dd09', ':"', i_dd09, '",');
    w_out := CONCAT_WS('', w_out, 'dd10', ':"', i_dd10, '",');
    w_out := CONCAT_WS('', w_out, 'dd11', ':"', i_dd11, '",');
    w_out := CONCAT_WS('', w_out, 'dd12', ':"', i_dd12, '",');
    w_out := CONCAT_WS('', w_out, 'dd13', ':"', i_dd13, '",');
    w_out := CONCAT_WS('', w_out, 'dd14', ':"', i_dd14, '",');
    w_out := CONCAT_WS('', w_out, 'dd15', ':"', i_dd15, '",');
    w_out := CONCAT_WS('', w_out, 'dd16', ':"', i_dd16, '",');
    w_out := CONCAT_WS('', w_out, 'dd17', ':"', i_dd17, '",');
    w_out := CONCAT_WS('', w_out, 'dd18', ':"', i_dd18, '",');
    w_out := CONCAT_WS('', w_out, 'dd19', ':"', i_dd19, '",');
    w_out := CONCAT_WS('', w_out, 'dd20', ':"', i_dd20, '",');
    w_out := CONCAT_WS('', w_out, 'dd21', ':"', i_dd21, '",');
    w_out := CONCAT_WS('', w_out, 'dd22', ':"', i_dd22, '",');
    w_out := CONCAT_WS('', w_out, 'dd23', ':"', i_dd23, '",');
    w_out := CONCAT_WS('', w_out, 'dd24', ':"', i_dd24, '",');
    w_out := CONCAT_WS('', w_out, 'dd25', ':"', i_dd25, '",');
    w_out := CONCAT_WS('', w_out, 'dd26', ':"', i_dd26, '",');
    w_out := CONCAT_WS('', w_out, 'dd27', ':"', i_dd27, '",');
    w_out := CONCAT_WS('', w_out, 'dd28', ':"', i_dd28, '",');
    CASE w_dd
        WHEN 28 THEN
            NULL;
        WHEN 29 THEN
            w_out := CONCAT_WS('', w_out, 'dd29', ':"', i_dd29, '"');
        WHEN 30 THEN
            w_out := CONCAT_WS('', w_out, 'dd29', ':"', i_dd29, '",');
            w_out := CONCAT_WS('', w_out, 'dd30', ':"', i_dd30, '"');
        WHEN 31 THEN
            w_out := CONCAT_WS('', w_out, 'dd29', ':"', i_dd29, '",');
            w_out := CONCAT_WS('', w_out, 'dd30', ':"', i_dd30, '",');
            w_out := CONCAT_WS('', w_out, 'dd31', ':"', i_dd31, '"');
        ELSE
            NULL;
    END CASE;
    RETURN w_out;
END;
$BODY$
LANGUAGE  plpgsql;