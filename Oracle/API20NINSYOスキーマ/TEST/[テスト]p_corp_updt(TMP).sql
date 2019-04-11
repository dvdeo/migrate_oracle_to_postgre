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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_uid          := null;
--  i_passwd       := 'passwd';
--  i_cid          := 'testcid';
--  i_cname        := 'cname';
  i_cname_kana   := null;
--  i_addr         := 'addr';
--  i_post         := 'post';
--  i_tel          := 'tel';
--  i_dept         := 'dept';
--  i_s_date       := 1;
  i_s_date       := null;
  i_e_date       := null;
--  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := null;
  i_end_flg      := null;
--  i_usage        := null;
  i_name         := null;
  i_version      := null;
--  i_rprt_flg     := '1';
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('PASSWD='      || i_passwd);
  dbms_output.put_line('CID='         || i_cid);
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
-- １件検索テスト（POS=1以外）
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_uid          := null;
--  i_cid          := 'testcid';
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
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 2;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

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
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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



-- *************************************
-- 検索エラーテスト(企業ID無しエラー) rtncd=0001
-- *************************************
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'S';
  i_uid          := null;
  --i_cid          := 'testcid';
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
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

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
  i_s_date       := '20110405000000';
  i_e_date       := '20111231000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := 'usage';
  i_name         := 'NAME';
  i_version      := '2.0';
  i_rprt_flg     := '1';
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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

select * from AUTH_MVIEW@AUTHPUB       where cid='testcid';
select * from AUTH_NOREF_MVIEW@AUTHPUB where cid='testcid';


-- ************************************
-- 登録エラーテスト(ユーザーID無し)@ rtncd=0004
-- ************************************
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_uid          := 'AAAAA';
  i_cid          := 'ssssssssssss';
  i_passwd       := null;
  i_cname        := 'ネクスト';
  i_cname_kana   := 'ネクスト';
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  i_dept         := '';
--  i_s_date       := null;
--  i_e_date       := null;
--  i_s_date_op    := null;
--  i_e_date_op    := null;
  i_sales_id     := null;
  i_other_maddr  := null;
  i_end_flg      := null;
  i_usage        := null;
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
-- 登録エラーテスト(企業ID有りエラー) rtncd=0002
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := 'passwd';
  i_cname        := 'cname';
  i_cname_kana   := 'cname_kana';
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  i_dept         := '';
  i_s_date       := '20110705000000';
  i_e_date       := '20111231000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := null;
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
-- 登録エラーテスト(NULLは挿入できない) rtncd = 7001
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'I';
  i_uid          := '00084';
  i_cid          := null;
  i_passwd       := null;
  i_cname        := null;
  i_cname_kana   := 'ネクスト';
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  i_dept         := '';
--  i_s_date       := null;
--  i_e_date       := null;
--  i_s_date_op    := null;
--  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'next@co.jp';
  i_end_flg      := null;
  i_usage        := null;
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := '00084';
  i_cid          := 'testcid';
  i_passwd       := 'upasswd';
  i_cname        := 'ucname';
  i_cname_kana   := 'ucname_kana';
  i_addr         := 'uaddr';
  i_post         := 'upost';
  i_tel          := 'utel';
  i_dept         := 'udept';
  i_s_date       := '20110406000000';
  i_e_date       := '20111231000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '00084';
  i_other_maddr  := 'hogehoge@zenrin-datacom.net';
  i_end_flg      := 1;
  i_usage        := 'uusage';
  i_name         := 'uNAME';
  i_version      := '2.1';
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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


-- ***********************************
-- 更新エラーテスト(ユーザーID無し) rtncd=0004
-- ***********************************
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'U';
  i_uid          := 'XXXX';
  i_cid          := 'testcid';
  i_passwd       := 'passwd';
  i_cname        := 'ucname';
  i_cname_kana   := 'ucname_kana';
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  i_dept         := 'udept';
  i_s_date       := '20110406000000';
  i_e_date       := '20110531000000';
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := 'XXXX';
  i_other_maddr  := 'hogehoge@zenrin-datacom.net';
  i_end_flg      := null;
  i_usage        := null;
  i_name         := 'uname';
  i_version      := '2.0';
  i_rprt_flg     := '0';
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);

  dbms_output.put_line('INS_DT='      || o_ins_dt);
  dbms_output.put_line('UPD_DT='      || o_upd_dt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/






-- ************************************
-- 更新エラーテスト(企業ID無しエラー) rtncd=0001
-- ************************************
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
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);

BEGIN
  i_kbn          := 'U';
  i_uid          := null;
  --i_cid          := 'TestCGI1';
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
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
-- 更新エラーテスト(NULLにUPDATE)@ RTNCD=7001
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'U';
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
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

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
--  i_sales_id     := '00084';
  i_other_maddr  := null;
  i_end_flg      := null;
--  i_usage        := '住所更新';
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := null;
  i_cnt          := null;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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

select * from AUTH_MVIEW@AUTHPUB       where cid='testcid';
select * from AUTH_NOREF_MVIEW@AUTHPUB where cid='testcid';



-- *************************************
-- 削除エラーテスト(企業ID無しエラー) rtncd=0001
-- *************************************
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        char(4);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'D';
  i_uid          := null;
  --i_cid          := 'TestCGI1';
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
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
  i_name         varchar2(128);
  i_version      varchar2(5);
  i_rprt_flg     char(1);
  i_pos          number(5);
  i_cnt          number(5);
  o_ins_dt       varchar2(14);
  o_upd_dt       varchar2(14);
  o_rtncd        varchar2(10);
  o_err_msg      varchar2(200);
  o_cnt          number(5);
  o_info         p_api20_corp_pkg_tmp.tbl_type;

BEGIN
  i_kbn          := 'K';
  i_uid          := 90141;
  i_cid          := '99999999GEO1234';
  i_passwd       := null;
  i_cname        := 'ネクスト';
  i_cname_kana   := 'ネクスト';
  i_addr         := null;
  i_post         := null;
  i_tel          := null;
  i_dept         := '';
  i_s_date       := null;
  i_e_date       := null;
  i_s_date_op    := null;
  i_e_date_op    := null;
  i_sales_id     := '90141';
  i_other_maddr  := 'next@co.jp';
  i_end_flg      := null;
  i_usage        := null;
  i_name         := null;
  i_version      := null;
  i_rprt_flg     := null;
  i_pos          := 1;
  i_cnt          := 10;

p_api20_corp_pkg_tmp.p_corp_updt(
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
  i_name,
  i_version,
  i_rprt_flg,
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
  dbms_output.put_line('NAME='        || i_name);
  dbms_output.put_line('VERSION='     || i_version);
  dbms_output.put_line('RPRT_FLG='    || i_rprt_flg);
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
