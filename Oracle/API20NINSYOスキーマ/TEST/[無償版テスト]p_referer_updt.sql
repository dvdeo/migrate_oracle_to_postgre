-- *********************************
-- 複数件検索テスト
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_key_num      number(8);
  i_cid          varchar2(15);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_uid          := null;
  i_cid          := null;
  i_key_num      := null;
  i_referer      := null;
  i_service_name := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 1件検索テスト(POS=1以外)
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_uid          := null;
  i_cid          := null;
  i_key_num      := null;
  i_referer      := 'http';
  i_service_name := null;
  i_pos          := 2;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 1件検索テスト
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_referer      := null;
  i_key_num      := 2;
  i_service_name := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 検索エラーテスト(企業IDなし) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_uid          := '00084';
  i_cid          := 'xxxx';
  i_referer      := null;
  i_key_num      := 1;
  i_service_name := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 検索エラーテスト(該当データ無し) RTNCD=0002
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_referer      := 'jejeje';
  i_key_num      := 3;
  i_service_name := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_key_num      := null;
  i_referer      := 'http://hogehoge.com/';
  i_service_name := 'service_name';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 登録エラーテスト(リファラー有りエラー) RTNCD=0003
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_key_num      := null;
  i_referer      := 'http://hogehoge.com/';
  i_service_name := 'service_name';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 更新テスト
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_key_num      := 2;
  i_referer      := 'http://hogehoge.netnet/';
  i_service_name := 'service_nameservice_name';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 更新エラーテスト(企業ID無しエラー) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'xxxxx';
  i_key_num      := 2;
  i_referer      := 'http://hogehoge.netnet/';
  i_service_name := 'service_nameservice_name';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 更新エラーテスト(該当データ無し) RTNCD=0002
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_key_num      := 3;
  i_referer      := 'http://hogehoge.netnet/';
  i_service_name := 'service_nameservice_name';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_key_num      := 2;
  i_referer      := null;
  i_service_name := 'service_name';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 削除エラーテスト(企業IDなし) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'XXXXX';
  i_key_num      := null;
  i_referer      := null;
  i_service_name := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
-- 削除エラーテスト(該当データ無し) RTNCD=0002
-- *********************************
set pagesize 10000
set linesize 160
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_key_num      := 4;
  i_referer      := null;
  i_service_name := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_key_num      number(8);
  i_referer      varchar2(100);
  i_service_name varchar2(256);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       char(14);
  o_upd_dt       char(14);
  o_rtncd        char(5);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'E';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_key_num      := null;
  i_referer      := null;
  i_service_name := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_referer_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_key_num,
  i_referer,
  i_service_name,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CID='           || i_cid);
  dbms_output.put_line('KEY_NUM='       || i_key_num);
  dbms_output.put_line('REFERER='       || i_referer);
  dbms_output.put_line('SERVICE_NAME='  || i_service_name);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

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




