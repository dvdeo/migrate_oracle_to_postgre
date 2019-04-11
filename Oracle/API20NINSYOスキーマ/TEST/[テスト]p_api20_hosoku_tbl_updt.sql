-- *********************************
-- 検索エラーテスト(KEY_NUMの指定なし)
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'S';
  i_uid             := '90141';
  i_corp_id         := null;
  i_key_num         := null;
  i_hosoku_kbn      := null;
  i_hosoku_title    := null;
  i_hosoku_detail   := null;
  i_userid          := null;
  i_pos             := null;
  i_cnt             := null;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- 検索エラーテスト(POD=1以外)
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'S';
  i_uid             := '90141';
  i_corp_id         := 'sss';
  i_key_num         := 1;
  i_hosoku_kbn      := null;
  i_hosoku_title    := null;
  i_hosoku_detail   := null;
  i_userid          := null;
  i_pos             := 2;
  i_cnt             := 4;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- 検索テスト
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'S';
  i_uid             := '90141';
  i_corp_id         := 'sss';
  i_key_num         := 1;
  i_hosoku_kbn      := null;
  i_hosoku_title    := null;
  i_hosoku_detail   := null;
  i_userid          := null;
  i_pos             := 1;
  i_cnt             := 4;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

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
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'I';
  i_uid             := '90141';
  i_corp_id         := 'sss';
  i_key_num         := null;
  i_hosoku_kbn      := 'U';
  i_hosoku_title    := 'お試し';
  i_hosoku_detail   := 'お試し 4/11';
  i_userid          := '90141';
  i_pos             := null;
  i_cnt             := null;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/




-- *********************************
-- 登録エラーテスト
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'I';
  i_uid             := '90141';
  i_corp_id         := 'sss';
  i_key_num         := 1;
  i_hosoku_kbn      := null;
  i_hosoku_title    := null;
  i_hosoku_detail   := null;
  i_userid          := null;
  i_pos             := 1;
  i_cnt             := 4;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

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
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'U';
  i_uid             := '90141';
  i_corp_id         := 'sss';
  i_key_num         := 1;
  i_hosoku_kbn      := 'U';
  i_hosoku_title    := 'お試し';
  i_hosoku_detail   := 'お試し 4/14';
  i_userid          := '90141';
  i_pos             := null;
  i_cnt             := null;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

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
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'D';
  i_uid             := '90141';
  i_corp_id         := 'sss';
  i_key_num         := 1;
  i_hosoku_kbn      := 'U';
  i_hosoku_title    := 'お試し';
  i_hosoku_detail   := 'お試し 4/14';
  i_userid          := '90141';
  i_pos             := null;
  i_cnt             := null;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/




-- *********************************
-- 更新区分エラーテスト
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'K';
  i_uid             := '90141';
  i_corp_id         := 'sss';
  i_key_num         := 1;
  i_hosoku_kbn      := 'U';
  i_hosoku_title    := 'お試し';
  i_hosoku_detail   := 'お試し 4/14';
  i_userid          := '90141';
  i_pos             := null;
  i_cnt             := null;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/




-- *********************************
-- 検索エラーテスト(該当データ無し)
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_corp_id         varchar2(15);
  i_key_num         number(8);
  i_hosoku_kbn      varchar2(2);
  i_hosoku_title    varchar2(128);
  i_hosoku_detail   varchar2(4000);
  i_userid          varchar2(5);
  i_pos             number;
  i_cnt             number;
  o_ins_dt          varchar2(14);
  o_upd_dt          varchar2(14);
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_api20_hosoku_pkg.tbl_type;

BEGIN
  i_kbn             := 'S';
  i_uid             := '90141';
  i_corp_id         := 'sssssss';
  i_key_num         := '7';
  i_hosoku_kbn      := null;
  i_hosoku_title    := null;
  i_hosoku_detail   := null;
  i_userid          := null;
  i_pos             := null;
  i_cnt             := null;

p_api20_hosoku_pkg.p_api20_hosoku_tbl_updt(
  i_kbn,
  i_uid,
  i_corp_id,
  i_key_num,
  i_hosoku_kbn,
  i_hosoku_title,
  i_hosoku_detail,
  i_userid,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CORP_ID='     || i_corp_id);
  dbms_output.put_line('KEY_NUM='     || i_key_num);
  dbms_output.put_line('KBN='         || i_hosoku_kbn);
  dbms_output.put_line('TITLE='       || i_hosoku_title);
  dbms_output.put_line('DETAIL='      || i_hosoku_detail);
  dbms_output.put_line('USERID='      || i_userid);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/

