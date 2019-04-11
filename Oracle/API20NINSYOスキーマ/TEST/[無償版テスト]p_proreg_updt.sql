-- *********************************
-- 検索テスト
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_id           := 'testid';
--  i_maddr        := 'hoge@zenrin-datacom.net';
  i_maddr        := null;

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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
-- 検索エラーテスト(該当データ無しエラー) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_id           := 'testid';
  i_maddr        := 'xxx@zenrin-datacom.net';

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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
-- 登録テスト
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_id           := 'testid';
  i_maddr        := 'hoge@zenrin-datacom.net';

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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
-- 登録エラーテスト(ID有り(重複)エラー) RTNCD=0002
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_id           := 'testid';
  i_maddr        := 'xxx@zenrin-datacom.net';

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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
-- 登録エラーテスト(メールアドレス有り(重複)エラー) RTNCD=0003
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_id           := 'testid2';
  i_maddr        := 'hoge@zenrin-datacom.net';

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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
-- 削除テスト
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_id           := 'testid';
  i_maddr        := null;

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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


-- ************************************************
-- 削除エラーテスト(id該当無しエラー) RTNCD=0001
-- ************************************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_id           := 'estid';
  i_maddr        := null;

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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


-- ***************************************************
-- 削除エラーテスト(メールアドレス該当無し) RTNCD=0001
-- ***************************************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_id           := 'testid';
  i_maddr        := 'xxxx@zenrin-datacom.net';

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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
-- 更新区分エラーテスト RTNCD=0099
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_id           varchar2(15);
  i_maddr        varchar2(100);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'E';
  i_id           := 'testid';
  i_maddr        := 'xxxx@zenrin-datacom.net';

p_fapi20_pkg.p_proreg_updt(
  i_kbn,
  i_id,
  i_maddr,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('ID='            || i_id);
  dbms_output.put_line('MADDR='         || i_maddr);

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




