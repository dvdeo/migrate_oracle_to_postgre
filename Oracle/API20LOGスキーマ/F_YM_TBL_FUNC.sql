CREATE OR REPLACE FUNCTION "API20LOG".f_ym_tbl_func (
  i_s_ym	in	varchar2,
  i_e_ym	in	varchar2
) return ym_tbl_type as
  w_ym_tbl	ym_tbl_type;
  w_cnt		number;
begin
  w_ym_tbl := ym_tbl_type();

  w_cnt := trunc((to_date(i_e_ym, 'yyyymm') - to_date(i_s_ym, 'yyyymm') + 31) / 30);

  for i in 1..w_cnt loop
    w_ym_tbl.extend(1);
    w_ym_tbl(i) := to_char(add_months(to_date(i_s_ym, 'yyyymm'), i - 1), 'yyyymm');
  end loop;

  return w_ym_tbl;
end;