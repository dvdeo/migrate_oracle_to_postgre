CREATE OR REPLACE FUNCTION api20ninsyo.p_del_fapi20_pwdcfm(OUT o_rtncd DOUBLE PRECISION)
AS
$BODY$
DECLARE
    w_rtncd DOUBLE PRECISION;
    error_transaction$returned_sqlstate TEXT;
    error_transaction$message_text TEXT;
      error_transaction$pg_exception_context TEXT;
BEGIN
    o_rtncd := 0;
    DELETE FROM api20ninsyo.fapi20_pwdcfm_tbl
        WHERE upd_dt < aws_oracle_ext.SYSDATE() - (1::NUMERIC / 24::NUMERIC || ' days')::INTERVAL;
    EXCEPTION
        WHEN OTHERS THEN
            GET STACKED DIAGNOSTICS error_transaction$returned_sqlstate = RETURNED_SQLSTATE,
                error_transaction$message_text = MESSAGE_TEXT,
                  error_transaction$pg_exception_context = PG_EXCEPTION_CONTEXT;
            RAISE NOTICE '% % %', error_transaction$returned_sqlstate, error_transaction$message_text || chr(10),   error_transaction$pg_exception_context;
            RETURN NULL;
END;
$BODY$
LANGUAGE  plpgsql;