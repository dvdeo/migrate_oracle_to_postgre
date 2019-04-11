CREATE OR REPLACE FUNCTION api20log.chg_ym(IN i_ym TEXT)
RETURNS TEXT
AS
$BODY$
DECLARE
    w_ym CHARACTER VARYING(6);
/* w_ym := case when to_char(sysdate,'yyyymm') = i_ym and to_char(sysdate,'dd') = '01' then to_char(add_months(to_date(i_ym,'yyyymm'),-1),'yyyymm') else i_ym end; */
BEGIN
    w_ym := i_ym
    /* 2011.11.08  玉川  変更 */;
    RETURN w_ym;
END;
$BODY$
LANGUAGE  plpgsql;