-- *********************************
-- �o�^�e�X�g
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
BEGIN
  i_uid          := '00084';
  i_cid          := 'testcid';

p_fapi20_pkg.p_reg(
  i_uid,
  i_cid,
  o_rtncd,
  o_err_msg
);

  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CID='         || i_cid);

  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/

-- *********************************
-- �o�^�G���[�e�X�g(���ID�����G���[) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
BEGIN
  i_uid          := '00084';
  i_cid          := 'XXXXX';

p_fapi20_pkg.p_reg(
  i_uid,
  i_cid,
  o_rtncd,
  o_err_msg
);

  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CID='         || i_cid);

  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/

-- *********************************
-- �o�^�G���[�e�X�g(��ƗL��G���[) RTNCD=0002
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
BEGIN
  i_uid          := '00084';
  i_cid          := 'testcid';

p_fapi20_pkg.p_reg(
  i_uid,
  i_cid,
  o_rtncd,
  o_err_msg
);

  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CID='         || i_cid);

  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/

