CREATE OR REPLACE FUNCTION "API20NINSYO".func_split (
  i_value   in   varchar2,       -- 文字列
  i_char    in   char            -- 区切り文字
) return func_split_type
is
  s_pos     number;
  e_pos     number;
  w_val     varchar2(1000);

  val_cnt   pls_integer;
  rtn_val   func_split_type;
begin
  -- 返却変数クリア
  rtn_val := func_split_type();

  if i_value is not null then
    val_cnt := 0;
    s_pos := 1;
    while s_pos <= length(i_value) loop
      e_pos := instr(i_value, i_char, s_pos, 1);
      if e_pos = 0 then
        w_val := substr(i_value, s_pos);
      else
        w_val := substr(i_value, s_pos, case when e_pos = 0 then null else e_pos - s_pos end);
      end if;

--    dbms_output.put_line('s_pos=' || s_pos || '   e_pos=' ||e_pos || '   val=' || w_val);

      val_cnt := val_cnt + 1;
      rtn_val.extend(1);
      rtn_val(val_cnt) := w_val;

      if e_pos > 0 then
        s_pos := e_pos + 1;
      else
        s_pos := length(i_value) + 1;
      end if;
    end loop;
  end if;

  return rtn_val;
exception
  when others then
    return null;
end;