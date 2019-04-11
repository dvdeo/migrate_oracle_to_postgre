CREATE OR REPLACE FUNCTION api20ninsyo.func_split(IN i_value TEXT, IN i_char TEXT)
RETURNS api20ninsyo.func_split_type
AS
$BODY$
DECLARE
    s_pos DOUBLE PRECISION;
    e_pos DOUBLE PRECISION;
    w_val CHARACTER VARYING(1000);
    val_cnt INTEGER;
    rtn_val api20ninsyo.func_split_type;
/* 返却変数クリア */
BEGIN
    rtn_val := ARRAY[]::api20ninsyo.func_split_type;

    IF i_value IS NOT NULL THEN
        val_cnt := 0;
        s_pos := 1;

        WHILE s_pos <= LENGTH(i_value) LOOP
            e_pos := aws_oracle_ext.INSTR(i_value, i_char, TRUNC(s_pos::NUMERIC)::INTEGER, 1);

            IF e_pos = 0 THEN
                w_val := aws_oracle_ext.substr(i_value, s_pos);
            ELSE
                w_val := aws_oracle_ext.substr(i_value, s_pos,
                CASE
                    WHEN e_pos = 0 THEN NULL
                    ELSE e_pos - s_pos
                END::NUMERIC);
            END IF
            /* dbms_output.put_line('s_pos=' || s_pos || '   e_pos=' ||e_pos || '   val=' || w_val); */;
            val_cnt := val_cnt + 1;
            rtn_val := aws_oracle_ext.EXTEND(rtn_val, 1);
            rtn_val[val_cnt] := w_val;

            IF e_pos > 0 THEN
                s_pos := e_pos + 1;
            ELSE
                s_pos := LENGTH(i_value) + 1;
            END IF;
        END LOOP;
    END IF;
    RETURN rtn_val;
    EXCEPTION
        WHEN others THEN
            RETURN NULL;
END;
$BODY$
LANGUAGE  plpgsql;