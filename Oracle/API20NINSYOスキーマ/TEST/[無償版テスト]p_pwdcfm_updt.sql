-- *********************************
-- �����e�X�g
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_id           := 'testid';
--  i_cid          := 'testcid';
  i_cid          := null;

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/

-- *********************************
-- �����G���[�e�X�g(�Y���f�[�^�����G���[) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_id           := 'XXXX';
  i_cid          := 'testcid';

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- �o�^�e�X�g
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_id           := 'testid';
  i_cid          := 'testcid';

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- �o�^�G���[�e�X�g(ID�L��(�d��)�G���[) RTNCD=0002
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_id           := 'testid';
  i_cid          := 'testcid';

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- �o�^�G���[�e�X�g(���ID�L��(�d��)�G���[) RTNCD=0003
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_id           := 'XXXX';
  i_cid          := 'testcid';

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- �폜�e�X�g
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_id           := 'testid';
  i_cid          := null;

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- �폜�G���[�e�X�g(�Y��id����) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_id           := 'estid';
  i_cid          := null;

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- �폜�G���[�e�X�g(�Y�����ID�����G���[) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_id           := 'testid';
  i_cid          := 'XXXX';

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/



-- *********************************
-- �X�V�敪�G���[�e�X�g RTNCD=0099
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_cid          varchar2(15);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'E';
  i_id           := 'testid';
  i_cid          := 'testcid';

p_fapi20_pkg.p_pwdcfm_updt(
  i_kbn,
  i_id,
  i_cid,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('CID='           || i_cid);

  dbms_output.put_line('INS_DT='        || o_ins_dt);
  dbms_output.put_line('UPD_DT='        || o_upd_dt);
  dbms_output.put_line('RTNCD='         || o_rtncd);
  dbms_output.put_line('ERRMSG='        || o_err_msg);
  dbms_output.put_line('CNT='           || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/




