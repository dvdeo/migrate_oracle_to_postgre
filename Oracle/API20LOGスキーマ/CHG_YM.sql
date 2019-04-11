CREATE OR REPLACE FUNCTION "API20LOG".chg_ym (
  i_ym		in varchar2
) return varchar2
as
  w_ym		varchar2(6);
begin
--  w_ym := case when to_char(sysdate,'yyyymm') = i_ym and to_char(sysdate,'dd') = '01' then to_char(add_months(to_date(i_ym,'yyyymm'),-1),'yyyymm') else i_ym end;
  w_ym := i_ym;		-- 2011.11.08  玉川  変更

  return w_ym;
end;