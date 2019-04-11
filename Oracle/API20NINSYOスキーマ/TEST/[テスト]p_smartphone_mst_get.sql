set pagesize 10000
set linesize 150
set serveroutput on
DECLARE
  i_ua           varchar2(100);
  o_rtncd        varchar2(5);
  o_info         typ_ret_to_php;

BEGIN
  i_ua          := 'F-05D';
  --i_ua          := 'iPhone';
  --i_ua          := 'SC-02D';
  --i_ua          := 'SC-02E';

  p_smartphone_mst_get(
    i_ua,
    o_info,
    o_rtncd
  );

  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('RTNCD='       || o_rtncd);

  for i in o_info.first..o_info.last loop
    dbms_output.put_line(o_info(i));
  end loop;
end;
/


