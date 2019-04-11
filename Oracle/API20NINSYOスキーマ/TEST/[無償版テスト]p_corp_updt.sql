-- *********************************
-- 複数件検索テスト（CID指定無し）
-- *********************************
set pagesize 10000
set linesize 150
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_passwd       varchar2(10);
  i_cid          varchar2(15);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;


BEGIN
  i_kbn          := 'S';
  i_uid          := null;
--  i_passwd       := 'passwd';
--  i_cid          := 'testcid';
  i_cname        := 'name';
  i_cname_kana   := null;
--  i_addr         := 'addr';
--  i_post         := 'post';
--  i_tel          := 'tel';
--  i_dept         := 'dept';
--  i_s_date       := 1;
  i_s_date       := null;
--  i_e_date       := 20150430000000;
--  i_s_date_op    := null;
--  i_e_date_op    := 2;
--  i_sales_id     := '00084';
  i_other_maddr  := null;
  i_end_flg      := null;
--  i_usage        := 'usage';
--  i_maddr        := 'hogehoge@zenrin-datacom.net';
--  i_hack_flg     := '1';
--  i_note         := 'note';
--  i_name         := 'NAME';
--  i_user_flg     := '0';
--  i_know_trigger := 'KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;


p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);


  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/




-- *********************************
-- １件検索テスト（CID指定）
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;


BEGIN
  i_kbn          := 'S';
  i_uid          := null;
  i_cid          := 'testcid';
  i_passwd       := null;
  i_cname        := null;
  i_cname_kana   := null;
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  i_dept         := null;
  i_s_date       := null;
  i_e_date       := null;
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := null;
  i_other_maddr  := null;
  i_end_flg      := null;
  i_usage        := null;
  i_maddr        := null;
  i_hack_flg     := null;
  i_note         := null;
  i_name         := null;
  i_user_flg     := null;
  i_know_trigger := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
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
  dbms_output.put_line('CID='         || i_cid);
  dbms_output.put_line('PASSWD='      || i_passwd);
  dbms_output.put_line('CNAME='       || i_cname);
  dbms_output.put_line('CNAME_KANA='  || i_cname_kana);
  dbms_output.put_line('ADDR='        || i_addr);
  dbms_output.put_line('POST='        || i_post);
  dbms_output.put_line('TEL='         || i_tel);
  dbms_output.put_line('DEPT='        || i_dept);
  dbms_output.put_line('S_DATE='      || i_s_date);
  dbms_output.put_line('E_DATE='      || i_e_date);
  dbms_output.put_line('S_DATE_OP='   || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='   || i_e_date_op);
  dbms_output.put_line('SALES_ID='    || i_sales_id);
  dbms_output.put_line('OTHER_MADDR=' || i_other_maddr);
  dbms_output.put_line('END_FLG='     || i_end_flg);
  dbms_output.put_line('USAGE='       || i_usage);
  dbms_output.put_line('MADDR='       || i_maddr);
  dbms_output.put_line('HACK_FLG='    || i_hack_flg);
  dbms_output.put_line('NOTE='        || i_note);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);
  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('NAME='       || i_name);
  dbms_output.put_line('USER_FLG='      || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER='         || i_know_trigger);


  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/



-- *********************************
-- 検索エラーテスト(企業ID無しエラー) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;


BEGIN
  i_kbn          := 'S';
  i_uid          := null;
  i_cid          := 'KKK';
  i_passwd       := null;
  i_cname        := null;
  i_cname_kana   := null;
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  
  i_dept         := null;
  i_s_date       := null;
  i_e_date       := null;
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := null;
  i_other_maddr  := null;
  i_end_flg      := null;
  i_usage        := null;
  i_usage        := null;
  i_maddr        := null;
  i_hack_flg     := null;
  i_note         := null;
  i_name         := null;
  i_user_flg     := null;
  i_know_trigger := null;
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_name,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info

);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);

  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);


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
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;


BEGIN
  i_kbn          := 'I';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := 'passwd';
  i_cname        := 'cname';
  i_cname_kana   := 'cname_kana';
  i_addr         := 'addr';
  i_post         := 'post';
  i_tel          := 'tel';
  i_dept         := 'dept';
  i_s_date       := '20140501000000';
  i_e_date       := '20150430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usage';
  i_maddr        := 'hogehoge@zenrin-datacom.net';
  i_hack_flg     := '1';
  i_note         := 'note';
  i_name         := 'NAME';
  i_user_flg     := '0';
  i_know_trigger := 'KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;


p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- 登録エラーテスト(ユーザーID無し) RTNCD=0004
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;


BEGIN
  i_kbn          := 'I';
  i_uid          := '00084';
  i_cid          := 'cid';
  i_passwd       := 'passwd';
  i_cname        := 'cname';
  i_cname_kana   := 'cname_kana';
  i_addr         := 'addr';
  i_post         := 'post';
  i_tel          := 'tel';
  i_dept         := 'dept';
  i_s_date       := '20140501000000';
  i_e_date       := '20150430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := 'XXXXX';
  i_other_maddr  := 'hoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usage';
  i_maddr        := 'hogehoge@zenrin-datacom.net';
  i_hack_flg     := '1';
  i_note         := 'note';
  i_name         := 'NAME';
  i_user_flg     := '0';
  i_know_trigger := 'KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);


  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/



-- *********************************
-- 登録エラーテスト(企業ID有りエラー) RTNCD=0002
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := 'passwd';
  i_cname        := 'cname';
  i_cname_kana   := 'cname_kana';
  i_addr         := 'addr';
  i_post         := 'post';
  i_tel          := 'tel';
  i_dept         := 'dept';
  i_s_date       := '20140501000000';
  i_e_date       := '20150430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usage';
  i_maddr        := 'hogehoge@zenrin-datacom.net';
  i_hack_flg     := '1';
  i_note         := 'note';
  i_name         := 'NAME';
  i_user_flg     := '0';
  i_know_trigger := 'KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);


  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- 登録エラーテスト(NULLは挿入できない) RTNCD=7001
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_uid          := '00084';
  i_cid          := null;
  i_passwd       := 'passwd';
  i_cname        := 'cname';
  i_cname_kana   := 'cname_kana';
  i_addr         := 'addr';
  i_post         := 'post';
  i_tel          := 'tel';
  i_dept         := 'dept';
  i_s_date       := '20140501000000';
  i_e_date       := '20150430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usage';
  i_maddr        := 'hogehoge@zenrin-datacom.net';
  i_hack_flg     := '1';
  i_note         := 'note';
  i_name         := 'NAME';
  i_user_flg     := '0';
  i_know_trigger := 'KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);


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
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := 'passwdpass';
  i_cname        := 'cnamecname';
  i_cname_kana   := 'cname_kanacname_kana';
  i_addr         := 'addraddr';
  i_post         := 'postpos';
  i_tel          := 'teltel';
  i_dept         := 'deptdept';
  i_s_date       := '20150501000000';
  i_e_date       := '20160430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hogehoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usageusage';
  i_maddr        := 'hogehogehoge@zenrin-datacom.net';
  i_hack_flg     := '0';
  i_note         := 'notenote';
  i_name         := 'update_NAME';
  i_user_flg     := '1';
  i_know_trigger := 'update_KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- 更新エラーテスト(ユーザーID無し) RTNCD=0004
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := 'passwdpass';
  i_cname        := 'cnamecname';
  i_cname_kana   := 'cname_kanacname_kana';
  i_addr         := 'addraddr';
  i_post         := 'postpos';
  i_tel          := 'teltel';
  i_dept         := 'deptdept';
  i_s_date       := '20150501000000';
  i_e_date       := '20160430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := 'XXXXX';
  i_other_maddr  := 'hogehoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usageusage';
  i_maddr        := 'hogehogehoge@zenrin-datacom.net';
  i_hack_flg     := '0';
  i_note         := 'notenote';
  i_name         := 'update_NAME';
  i_user_flg     := '0';
  i_know_trigger := 'update_KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);

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
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'XXXXX';
  i_passwd       := 'passwdpass';
  i_cname        := 'cnamecname';
  i_cname_kana   := 'cname_kanacname_kana';
  i_addr         := 'addraddr';
  i_post         := 'postpos';
  i_tel          := 'teltel';
  i_dept         := 'deptdept';
  i_s_date       := '20150501000000';
  i_e_date       := '20160430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hogehoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usageusage';
  i_maddr        := 'hogehogehoge@zenrin-datacom.net';
  i_hack_flg     := '0';
  i_note         := 'notenote';
  i_name         := 'update_NAME';
  i_user_flg     := '0';
  i_know_trigger := 'update_KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);


  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- 更新エラーテスト(NULLにUPDATE) RTNCD=7001
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := null;
  i_cname        := 'cnamecname';
  i_cname_kana   := 'cname_kanacname_kana';
  i_addr         := 'addraddr';
  i_post         := 'postpos';
  i_tel          := 'teltel';
  i_dept         := 'deptdept';
  i_s_date       := '20150501000000';
  i_e_date       := '20160430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hogehoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usageusage';
  i_maddr        := 'hogehogehoge@zenrin-datacom.net';
  i_hack_flg     := '0';
  i_note         := 'notenote';
  i_name         := 'update_NAME';
  i_user_flg     := '0';
  i_know_trigger := 'update_KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);

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
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := null;
  i_cname        := null;
  i_cname_kana   := null;
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  i_dept         := null;
  i_s_date       := null;
  i_e_date       := null;
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := null;
  i_end_flg      := null;
  i_usage        := null;
  i_maddr        := null;
  i_hack_flg     := null;
  i_note         := null;
  i_name         := null;
  i_user_flg     := null;
  i_know_trigger := null;
  i_pos          := null;
  i_cnt          := null;


p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/




-- *********************************
-- 削除エラーテスト(企業ID無しエラー) RTNCD=0001
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_uid          := '00084';
  i_cid          := 'XXXXX';
  i_passwd       := null;
  i_cname        := null;
  i_cname_kana   := null;
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  i_dept         := null;
  i_s_date       := null;
  i_e_date       := null;
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := null;
  i_end_flg      := null;
  i_usage        := null;
  i_maddr        := null;
  i_hack_flg     := null;
  i_note         := null;
  i_name         := null;
  i_user_flg     := null;
  i_know_trigger := null;
  i_pos          := null;
  i_cnt          := null;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/






-- *********************************
-- 更新区分エラー RTNCD=0099
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn          char(1);
  i_uid          varchar2(5);
  i_cid          varchar2(15);
  i_passwd       varchar2(10);
  i_cname        varchar2(128);
  i_cname_kana   varchar2(128);
  i_addr         varchar2(128);
  i_post         varchar2(7);
  i_tel          varchar2(15);
  i_dept         varchar2(128);
  i_s_date       varchar2(14);
  i_e_date       varchar2(14);
  i_s_date_op    varchar2(20);
  i_e_date_op    varchar2(20);
  i_sales_id     varchar2(5);
  i_other_maddr  varchar2(1000);
  i_end_flg      char(1);
  i_usage        varchar2(256);
  i_maddr        varchar2(100);
  i_hack_flg     char(1);
  i_note         varchar2(256);
  i_name         varchar2(128);
  i_user_flg     char(1);
  i_know_trigger varchar2(128);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_fapi20_pkg.tbl_type;

BEGIN
  i_kbn          := 'E';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := 'passwd';
  i_cname        := 'cname';
  i_cname_kana   := 'cname_kana';
  i_addr         := 'addr';
  i_post         := 'post';
  i_tel          := 'tel';
  i_dept         := 'dept';
  i_s_date       := '20140501000000';
  i_e_date       := '20150430000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usage';
  i_maddr        := 'hogehoge@zenrin-datacom.net';
  i_hack_flg     := '1';
  i_note         := 'note';
  i_name         := 'name';
  i_user_flg     := '0';
  i_know_trigger := 'KNOW_TRIGGER';
  i_pos          := 1;
  i_cnt          := 10;

p_fapi20_pkg.p_corp_updt(
  i_kbn,
  i_uid,
  i_cid,
  i_passwd,
  i_cname,
  i_cname_kana,
  i_addr,
  i_post,
  i_tel,
  i_dept,
  i_s_date,
  i_e_date,
  i_s_date_op,
  i_e_date_op,
  i_sales_id,
  i_other_maddr,
  i_end_flg,
  i_usage,
  i_maddr,
  i_hack_flg,
  i_note,
  i_name,
  i_user_flg,
  i_know_trigger,
  i_pos,
  i_cnt,
  o_ins_dt,
  o_upd_dt,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='          || i_kbn);
  dbms_output.put_line('UID='          || i_uid);
  dbms_output.put_line('CID='          || i_cid);
  dbms_output.put_line('PASSWD='       || i_passwd);
  dbms_output.put_line('CNAME='        || i_cname);
  dbms_output.put_line('CNAME_KANA='   || i_cname_kana);
  dbms_output.put_line('ADDR='         || i_addr);
  dbms_output.put_line('POST='         || i_post);
  dbms_output.put_line('TEL='          || i_tel);
  dbms_output.put_line('DEPT='         || i_dept);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALES_ID='     || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);
  dbms_output.put_line('MADDR='        || i_maddr);
  dbms_output.put_line('HACK_FLG='     || i_hack_flg);
  dbms_output.put_line('NOTE='         || i_note);
  dbms_output.put_line('NAME='         || i_name);
  dbms_output.put_line('USER_FLG='     || i_user_flg);
  dbms_output.put_line('KNOW_TRIGGER=' || i_know_trigger);
  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);
  dbms_output.put_line('INS_DT='       || o_ins_dt);
  dbms_output.put_line('UPD_DT='       || o_upd_dt);
  dbms_output.put_line('RTNCD='        || o_rtncd);
  dbms_output.put_line('ERRMSG='       || o_err_msg);
  dbms_output.put_line('CNT='          || o_cnt);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


