CREATE OR REPLACE FUNCTION "API20LOG".get_dd (
  i_ym		in varchar2,
  i_dd01	in varchar2,
  i_dd02	in varchar2,
  i_dd03	in varchar2,
  i_dd04	in varchar2,
  i_dd05	in varchar2,
  i_dd06	in varchar2,
  i_dd07	in varchar2,
  i_dd08	in varchar2,
  i_dd09	in varchar2,
  i_dd10	in varchar2,
  i_dd11	in varchar2,
  i_dd12	in varchar2,
  i_dd13	in varchar2,
  i_dd14	in varchar2,
  i_dd15	in varchar2,
  i_dd16	in varchar2,
  i_dd17	in varchar2,
  i_dd18	in varchar2,
  i_dd19	in varchar2,
  i_dd20	in varchar2,
  i_dd21	in varchar2,
  i_dd22	in varchar2,
  i_dd23	in varchar2,
  i_dd24	in varchar2,
  i_dd25	in varchar2,
  i_dd26	in varchar2,
  i_dd27	in varchar2,
  i_dd28	in varchar2,
  i_dd29	in varchar2,
  i_dd30	in varchar2,
  i_dd31	in varchar2
) return varchar2
as
  w_out		varchar2(4000);
  w_dd		number(2);
begin
  w_dd :=  to_number(to_char(last_day(to_date(i_ym, 'YYYYMM')), 'dd'));

  w_out := null;
  w_out := w_out || 'dd01' || ':"' || i_dd01 || '",';
  w_out := w_out || 'dd02' || ':"' || i_dd02 || '",';
  w_out := w_out || 'dd03' || ':"' || i_dd03 || '",';
  w_out := w_out || 'dd04' || ':"' || i_dd04 || '",';
  w_out := w_out || 'dd05' || ':"' || i_dd05 || '",';
  w_out := w_out || 'dd06' || ':"' || i_dd06 || '",';
  w_out := w_out || 'dd07' || ':"' || i_dd07 || '",';
  w_out := w_out || 'dd08' || ':"' || i_dd08 || '",';
  w_out := w_out || 'dd09' || ':"' || i_dd09 || '",';
  w_out := w_out || 'dd10' || ':"' || i_dd10 || '",';
  w_out := w_out || 'dd11' || ':"' || i_dd11 || '",';
  w_out := w_out || 'dd12' || ':"' || i_dd12 || '",';
  w_out := w_out || 'dd13' || ':"' || i_dd13 || '",';
  w_out := w_out || 'dd14' || ':"' || i_dd14 || '",';
  w_out := w_out || 'dd15' || ':"' || i_dd15 || '",';
  w_out := w_out || 'dd16' || ':"' || i_dd16 || '",';
  w_out := w_out || 'dd17' || ':"' || i_dd17 || '",';
  w_out := w_out || 'dd18' || ':"' || i_dd18 || '",';
  w_out := w_out || 'dd19' || ':"' || i_dd19 || '",';
  w_out := w_out || 'dd20' || ':"' || i_dd20 || '",';
  w_out := w_out || 'dd21' || ':"' || i_dd21 || '",';
  w_out := w_out || 'dd22' || ':"' || i_dd22 || '",';
  w_out := w_out || 'dd23' || ':"' || i_dd23 || '",';
  w_out := w_out || 'dd24' || ':"' || i_dd24 || '",';
  w_out := w_out || 'dd25' || ':"' || i_dd25 || '",';
  w_out := w_out || 'dd26' || ':"' || i_dd26 || '",';
  w_out := w_out || 'dd27' || ':"' || i_dd27 || '",';
  w_out := w_out || 'dd28' || ':"' || i_dd28 || '",';

  case w_dd
    when 28 then
      null;
    when 29 then
      w_out := w_out || 'dd29' || ':"' || i_dd29 || '"';
    when 30 then
      w_out := w_out || 'dd29' || ':"' || i_dd29 || '",';
      w_out := w_out || 'dd30' || ':"' || i_dd30 || '"';
    when 31 then
      w_out := w_out || 'dd29' || ':"' || i_dd29 || '",';
      w_out := w_out || 'dd30' || ':"' || i_dd30 || '",';
      w_out := w_out || 'dd31' || ':"' || i_dd31 || '"';
    else
      null;
  end case;

  return w_out;
end;