-- ********************************************
-- 複数件検索テスト（CORP_ID,KEY_NUM指定無し）
-- ********************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CORP_ID         varchar2(15);
  I_KEY_NUM         number(8);
  I_HOSOKU_KBN      varchar2(1);
  I_HOSOKU_TITLE    varchar2(128);
  I_HOSOKU_DETAIL   varchar2(4000);
  I_USERID          varchar2(5);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            p_oauth_pkg.tbl_type;

begin
  I_KBN             := 'S';
  I_UID             := null;
  I_CORP_ID         := null;
  I_KEY_NUM         := null;
  I_HOSOKU_KBN      := null;
  I_HOSOKU_TITLE    := null;
  I_HOSOKU_DETAIL   := null;
  I_USERID          := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_hosoku_tbl_updt(
    I_KBN,
    I_UID,
    I_CORP_ID,
    I_KEY_NUM,
    I_HOSOKU_KBN,
    I_HOSOKU_TITLE,
    I_HOSOKU_DETAIL,
    I_USERID,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CORP_ID='       || I_CORP_ID);
  dbms_output.put_line('KEY_NUM='       || I_KEY_NUM);
  dbms_output.put_line('HOSOKU_KBN='    || I_HOSOKU_KBN);
  dbms_output.put_line('HOSOKU_TITLE='  || I_HOSOKU_TITLE);
  dbms_output.put_line('HOSOKU_DETAIL=' || I_HOSOKU_DETAIL);
  dbms_output.put_line('USERID='        || I_USERID);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

  dbms_output.put_line('INS_DT='     || o_ins_dt);
  dbms_output.put_line('UPD_DT='     || o_upd_dt);
  dbms_output.put_line('RTNCD='      || o_rtncd);
  dbms_output.put_line('ERRMSG='     || o_err_msg);
  dbms_output.put_line('CNT='        || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/



-- ********************************************
-- １件検索テスト（CORP_ID,KEY_NUM指定）
-- ********************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CORP_ID         varchar2(15);
  I_KEY_NUM         number(8);
  I_HOSOKU_KBN      varchar2(1);
  I_HOSOKU_TITLE    varchar2(128);
  I_HOSOKU_DETAIL   varchar2(4000);
  I_USERID          varchar2(5);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            p_oauth_pkg.tbl_type;

begin
  I_KBN             := 'S';
  I_UID             := 'ebi';
  I_CORP_ID         := 'J003';
  I_KEY_NUM         := 3;
  I_HOSOKU_KBN      := null;
  I_HOSOKU_TITLE    := null;
  I_HOSOKU_DETAIL   := null;
  I_USERID          := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_hosoku_tbl_updt(
    I_KBN,
    I_UID,
    I_CORP_ID,
    I_KEY_NUM,
    I_HOSOKU_KBN,
    I_HOSOKU_TITLE,
    I_HOSOKU_DETAIL,
    I_USERID,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CORP_ID='       || I_CORP_ID);
  dbms_output.put_line('KEY_NUM='       || I_KEY_NUM);
  dbms_output.put_line('HOSOKU_KBN='    || I_HOSOKU_KBN);
  dbms_output.put_line('HOSOKU_TITLE='  || I_HOSOKU_TITLE);
  dbms_output.put_line('HOSOKU_DETAIL=' || I_HOSOKU_DETAIL);
  dbms_output.put_line('USERID='        || I_USERID);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

  dbms_output.put_line('INS_DT='     || o_ins_dt);
  dbms_output.put_line('UPD_DT='     || o_upd_dt);
  dbms_output.put_line('RTNCD='      || o_rtncd);
  dbms_output.put_line('ERRMSG='     || o_err_msg);
  dbms_output.put_line('CNT='        || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/



-- ********************************************
-- 登録テスト（KEY_NUM null指定）
-- ********************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CORP_ID         varchar2(15);
  I_KEY_NUM         number(8);
  I_HOSOKU_KBN      varchar2(1);
  I_HOSOKU_TITLE    varchar2(128);
  I_HOSOKU_DETAIL   varchar2(4000);
  I_USERID          varchar2(5);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            p_oauth_pkg.tbl_type;

begin
  I_KBN             := 'I';
  I_UID             := 'ebi';
  I_CORP_ID         := 'J004';
  I_KEY_NUM         := null;
  I_HOSOKU_KBN      := 'I';
  I_HOSOKU_TITLE    := 'ABC';
  I_HOSOKU_DETAIL   := null;
  I_USERID          := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_hosoku_tbl_updt(
    I_KBN,
    I_UID,
    I_CORP_ID,
    I_KEY_NUM,
    I_HOSOKU_KBN,
    I_HOSOKU_TITLE,
    I_HOSOKU_DETAIL,
    I_USERID,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CORP_ID='       || I_CORP_ID);
  dbms_output.put_line('KEY_NUM='       || I_KEY_NUM);
  dbms_output.put_line('HOSOKU_KBN='    || I_HOSOKU_KBN);
  dbms_output.put_line('HOSOKU_TITLE='  || I_HOSOKU_TITLE);
  dbms_output.put_line('HOSOKU_DETAIL=' || I_HOSOKU_DETAIL);
  dbms_output.put_line('USERID='        || I_USERID);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

  dbms_output.put_line('INS_DT='     || o_ins_dt);
  dbms_output.put_line('UPD_DT='     || o_upd_dt);
  dbms_output.put_line('RTNCD='      || o_rtncd);
  dbms_output.put_line('ERRMSG='     || o_err_msg);
  dbms_output.put_line('CNT='        || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/




-- ********************************************
-- 更新テスト
-- ********************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CORP_ID         varchar2(15);
  I_KEY_NUM         number(8);
  I_HOSOKU_KBN      varchar2(1);
  I_HOSOKU_TITLE    varchar2(128);
  I_HOSOKU_DETAIL   varchar2(4000);
  I_USERID          varchar2(5);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            p_oauth_pkg.tbl_type;

begin
  I_KBN             := 'U';
  I_UID             := 'ebi';
  I_CORP_ID         := 'J001';
  I_KEY_NUM         := 1;
  I_HOSOKU_KBN      := 'U';
  I_HOSOKU_TITLE    := '補足見出し';
  I_HOSOKU_DETAIL   := null;
  I_USERID          := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_hosoku_tbl_updt(
    I_KBN,
    I_UID,
    I_CORP_ID,
    I_KEY_NUM,
    I_HOSOKU_KBN,
    I_HOSOKU_TITLE,
    I_HOSOKU_DETAIL,
    I_USERID,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CORP_ID='       || I_CORP_ID);
  dbms_output.put_line('KEY_NUM='       || I_KEY_NUM);
  dbms_output.put_line('HOSOKU_KBN='    || I_HOSOKU_KBN);
  dbms_output.put_line('HOSOKU_TITLE='  || I_HOSOKU_TITLE);
  dbms_output.put_line('HOSOKU_DETAIL=' || I_HOSOKU_DETAIL);
  dbms_output.put_line('USERID='        || I_USERID);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

  dbms_output.put_line('INS_DT='     || o_ins_dt);
  dbms_output.put_line('UPD_DT='     || o_upd_dt);
  dbms_output.put_line('RTNCD='      || o_rtncd);
  dbms_output.put_line('ERRMSG='     || o_err_msg);
  dbms_output.put_line('CNT='        || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/




-- ********************************************
-- 削除テスト
-- ********************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CORP_ID         varchar2(15);
  I_KEY_NUM         number(8);
  I_HOSOKU_KBN      varchar2(1);
  I_HOSOKU_TITLE    varchar2(128);
  I_HOSOKU_DETAIL   varchar2(4000);
  I_USERID          varchar2(5);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            p_oauth_pkg.tbl_type;

begin
  I_KBN             := 'D';
  I_UID             := 'ebi';
  I_CORP_ID         := 'J001';
  I_KEY_NUM         := 1;
  I_HOSOKU_KBN      := 'U';
  I_HOSOKU_TITLE    := '補足見出し';
  I_HOSOKU_DETAIL   := null;
  I_USERID          := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_hosoku_tbl_updt(
    I_KBN,
    I_UID,
    I_CORP_ID,
    I_KEY_NUM,
    I_HOSOKU_KBN,
    I_HOSOKU_TITLE,
    I_HOSOKU_DETAIL,
    I_USERID,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='           || i_kbn);
  dbms_output.put_line('UID='           || i_uid);
  dbms_output.put_line('CORP_ID='       || I_CORP_ID);
  dbms_output.put_line('KEY_NUM='       || I_KEY_NUM);
  dbms_output.put_line('HOSOKU_KBN='    || I_HOSOKU_KBN);
  dbms_output.put_line('HOSOKU_TITLE='  || I_HOSOKU_TITLE);
  dbms_output.put_line('HOSOKU_DETAIL=' || I_HOSOKU_DETAIL);
  dbms_output.put_line('USERID='        || I_USERID);
  dbms_output.put_line('POS='           || i_pos);
  dbms_output.put_line('CNT='           || i_cnt);

  dbms_output.put_line('INS_DT='     || o_ins_dt);
  dbms_output.put_line('UPD_DT='     || o_upd_dt);
  dbms_output.put_line('RTNCD='      || o_rtncd);
  dbms_output.put_line('ERRMSG='     || o_err_msg);
  dbms_output.put_line('CNT='        || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/
