-- **********************************
-- 複数件検索テスト（CID指定無し）
-- **********************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN                 CHAR(1);
  I_UID                 VARCHAR2(15);
  I_CID                 VARCHAR2(16);
  I_PASSWD              VARCHAR2(10);
  I_CNAME               VARCHAR2(128);
  I_CNAME_KANA          VARCHAR2(128);
  I_ADDR                VARCHAR2(128);
  I_POST                VARCHAR2(7);
  I_TEL                 VARCHAR2(15);
  I_BUSYO               VARCHAR2(128);
  I_S_DATE              VARCHAR2(20);
  I_E_DATE              VARCHAR2(20);
  I_S_DATE_OP           VARCHAR2(20);
  I_E_DATE_OP           VARCHAR2(20);
  I_SERV_OP             VARCHAR2(20);
  I_SSL_FLG             VARCHAR2(20);
  I_API_USE_FLG         VARCHAR2(1);
  I_API_USE_LIST        VARCHAR2(4000);
  I_SALES_ID            VARCHAR2(5);
  I_OTHER_MADDR         VARCHAR2(1000);
  I_END_FLG             VARCHAR2(1);
  O_END_DT              VARCHAR2(20);
  I_SERVNAME            VARCHAR2(256);
  I_AGENCYID            VARCHAR2(15);
  I_ADID                VARCHAR2(100);
  I_ADKEY               VARCHAR2(100);
  I_ADPASSWD            VARCHAR2(100);
  I_MAPTYPE_LIST        VARCHAR2(100);
  I_OPT                 VARCHAR2(100);
  I_VOSKBN              P_OAUTH_PKG.TBL_TYPE;
  I_USAGE               VARCHAR2(1024);
  I_POS                 NUMBER;
  I_CNT                 NUMBER;
  O_INS_DT              VARCHAR2(20);
  O_UPD_DT              VARCHAR2(20);
  O_RTNCD               VARCHAR2(10);
  O_ERR_MSG             VARCHAR2(1000);
  O_CNT                 NUMBER;
  O_INFO                P_OAUTH_PKG.TBL_TYPE;

begin
  I_KBN                 := 'S';
  I_UID                 := null;
  I_CID                 := null;
  I_PASSWD              := null;
  I_CNAME               := null;
  I_CNAME_KANA          := null;
  I_ADDR                := null;
  I_POST                := null;
  I_TEL                 := null;
  I_BUSYO               := null;
  I_S_DATE              := null;
  I_E_DATE              := null;
  I_S_DATE_OP           := null;
  I_E_DATE_OP           := null;
  I_SALES_ID            := null;
  I_OTHER_MADDR         := null;
  I_END_FLG             := null;
  I_USAGE               := null;
  I_POS                 := 1;
  I_CNT                 := 100;

  p_oauth_pkg.p_corp_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_PASSWD,
    I_CNAME,
    I_CNAME_KANA,
    I_ADDR,
    I_POST,
    I_TEL,
    I_BUSYO,
    I_S_DATE,
    I_E_DATE,
    I_S_DATE_OP,
    I_E_DATE_OP,
    I_SALES_ID,
    I_OTHER_MADDR,
    I_END_FLG,
    I_USAGE,
    I_POS,
    I_CNT,
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
  dbms_output.put_line('BUSYO='        || i_busyo);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALESID='      || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);

  if i_voskbn.count > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in i_voskbn.first..i_voskbn.last loop
      dbms_output.put_line(i_voskbn(i));
    end loop;
    dbms_output.put_line('-----------------------------------');
  end if;

  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);

  dbms_output.put_line('END_DT='     || o_end_dt);
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




-- **********************************
-- １件検索テスト（CID指定）
-- **********************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN                 CHAR(1);
  I_UID                 VARCHAR2(15);
  I_CID                 VARCHAR2(16);
  I_PASSWD              VARCHAR2(10);
  I_CNAME               VARCHAR2(128);
  I_CNAME_KANA          VARCHAR2(128);
  I_ADDR                VARCHAR2(128);
  I_POST                VARCHAR2(7);
  I_TEL                 VARCHAR2(15);
  I_BUSYO               VARCHAR2(128);
  I_S_DATE              VARCHAR2(20);
  I_E_DATE              VARCHAR2(20);
  I_S_DATE_OP           VARCHAR2(20);
  I_E_DATE_OP           VARCHAR2(20);
  I_SALES_ID            VARCHAR2(5);
  I_OTHER_MADDR         VARCHAR2(1000);
  I_END_FLG             VARCHAR2(1);
  O_END_DT              VARCHAR2(20);
  I_USAGE               VARCHAR2(1024);
  I_VOSKBN              p_oauth_pkg.tbl_type;
  I_POS                 NUMBER;
  I_CNT                 NUMBER;
  O_INS_DT              VARCHAR2(20);
  O_UPD_DT              VARCHAR2(20);
  O_RTNCD               VARCHAR2(10);
  O_ERR_MSG             VARCHAR2(1000);
  O_CNT                 NUMBER;
  O_INFO                P_OAUTH_PKG.TBL_TYPE;

begin
  I_KBN                 := 'S';
  I_UID                 := null;
  I_CID                 := 'J001';
  I_PASSWD              := null;
  I_CNAME               := null;
  I_CNAME_KANA          := null;
  I_ADDR                := null;
  I_POST                := null;
  I_TEL                 := null;
  I_BUSYO               := null;
  I_S_DATE              := null;
  I_E_DATE              := null;
  I_S_DATE_OP           := null;
  I_E_DATE_OP           := null;
  I_SALES_ID            := null;
  I_OTHER_MADDR         := null;
  I_END_FLG             := null;
  I_USAGE               := null;
  I_POS                 := 1;
  I_CNT                 := 1;

  p_oauth_pkg.p_corp_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_PASSWD,
    I_CNAME,
    I_CNAME_KANA,
    I_ADDR,
    I_POST,
    I_TEL,
    I_BUSYO,
    I_S_DATE,
    I_E_DATE,
    I_S_DATE_OP,
    I_E_DATE_OP,
    I_SALES_ID,
    I_OTHER_MADDR,
    I_END_FLG,
    I_USAGE,
    I_POS,
    I_CNT,
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
  dbms_output.put_line('BUSYO='        || i_busyo);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALESID='      || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);

  if i_voskbn.count > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in i_voskbn.first..i_voskbn.last loop
      dbms_output.put_line(i_voskbn(i));
    end loop;
    dbms_output.put_line('-----------------------------------');
  end if;

  dbms_output.put_line('POS='        || i_pos);
  dbms_output.put_line('CNT='        || i_cnt);

  dbms_output.put_line('END_DT='     || o_end_dt);
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







-- **********************************
-- 登録テスト
-- **********************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN                 CHAR(1);
  I_UID                 VARCHAR2(15);
  I_CID                 VARCHAR2(16);
  I_PASSWD              VARCHAR2(10);
  I_CNAME               VARCHAR2(128);
  I_CNAME_KANA          VARCHAR2(128);
  I_ADDR                VARCHAR2(128);
  I_POST                VARCHAR2(7);
  I_TEL                 VARCHAR2(15);
  I_BUSYO               VARCHAR2(128);
  I_S_DATE              VARCHAR2(20);
  I_E_DATE              VARCHAR2(20);
  I_S_DATE_OP           VARCHAR2(20);
  I_E_DATE_OP           VARCHAR2(20);
  I_SALES_ID            VARCHAR2(5);
  I_OTHER_MADDR         VARCHAR2(1000);
  I_END_FLG             VARCHAR2(1);
  O_END_DT              VARCHAR2(20);
  I_SERVNAME            VARCHAR2(256);
  I_AGENCYID            VARCHAR2(15);
  I_ADID                VARCHAR2(100);
  I_ADKEY               VARCHAR2(100);
  I_ADPASSWD            VARCHAR2(100);
  I_MAPTYPE_LIST        VARCHAR2(100);
  I_OPT                 VARCHAR2(100);
  I_USAGE               VARCHAR2(1024);
  I_VOSKBN              p_oauth_pkg.tbl_type;
  I_POS                 NUMBER;
  I_CNT                 NUMBER;
  O_INS_DT              VARCHAR2(20);
  O_UPD_DT              VARCHAR2(20);
  O_RTNCD               VARCHAR2(10);
  O_ERR_MSG             VARCHAR2(1000);
  O_CNT                 NUMBER;
  O_INFO                P_OAUTH_PKG.TBL_TYPE;
begin
  I_KBN                 := 'I';
  I_UID                 := 'ebi';
  I_CID                 := 'J005';
  I_PASSWD              := 'abc';
  I_CNAME               := 'abc';
  I_CNAME_KANA          := 'abc';
  I_ADDR                := 'abc';
  I_POST                := '1112222';
  I_TEL                 := '034445555';
  I_BUSYO               := '東京';
  I_S_DATE              := '20101201000000';
  I_E_DATE              := '20101201000000';
  I_S_DATE_OP           := sysdate;
  I_E_DATE_OP           := sysdate;
  I_SALES_ID            := 90141;
  I_OTHER_MADDR         := null;
  I_END_FLG             := '0';
  I_USAGE               := null;
  I_POS                 := 1;
  I_CNT                 := 1;

  p_oauth_pkg.p_corp_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_PASSWD,
    I_CNAME,
    I_CNAME_KANA,
    I_ADDR,
    I_POST,
    I_TEL,
    I_BUSYO,
    I_S_DATE,
    I_E_DATE,
    I_S_DATE_OP,
    I_E_DATE_OP,
    I_SALES_ID,
    I_OTHER_MADDR,
    I_END_FLG,
    I_USAGE,
    I_POS,
    I_CNT,
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
  dbms_output.put_line('BUSYO='        || i_busyo);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALESID='      || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);

  if i_voskbn.count > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in i_voskbn.first..i_voskbn.last loop
      dbms_output.put_line(i_voskbn(i));
    end loop;
    dbms_output.put_line('-----------------------------------');
  end if;

  dbms_output.put_line('POS='          || i_pos);
  dbms_output.put_line('CNT='          || i_cnt);

  dbms_output.put_line('END_DT='     || o_end_dt);
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




-- **********************************
-- 更新テスト
-- **********************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN                 CHAR(1);
  I_UID                 VARCHAR2(15);
  I_CID                 VARCHAR2(16);
  I_PASSWD              VARCHAR2(10);
  I_CNAME               VARCHAR2(128);
  I_CNAME_KANA          VARCHAR2(128);
  I_ADDR                VARCHAR2(128);
  I_POST                VARCHAR2(7);
  I_TEL                 VARCHAR2(15);
  I_BUSYO               VARCHAR2(128);
  I_S_DATE              VARCHAR2(20);
  I_E_DATE              VARCHAR2(20);
  I_S_DATE_OP           VARCHAR2(20);
  I_E_DATE_OP           VARCHAR2(20);
  I_SALES_ID            VARCHAR2(5);
  I_OTHER_MADDR         VARCHAR2(1000);
  I_END_FLG             VARCHAR2(1);
  O_END_DT              VARCHAR2(20);
  I_USAGE               VARCHAR2(1024);
  I_VOSKBN              p_oauth_pkg.tbl_type;
  I_POS                 NUMBER;
  I_CNT                 NUMBER;
  O_INS_DT              VARCHAR2(20);
  O_UPD_DT              VARCHAR2(20);
  O_RTNCD               VARCHAR2(10);
  O_ERR_MSG             VARCHAR2(1000);
  O_CNT                 NUMBER;
  O_INFO                P_OAUTH_PKG.TBL_TYPE;

begin
  I_KBN                 := 'U';
  I_UID                 := 'ebi';
  I_CID                 := 'J001';
  I_PASSWD              := 'abcabc';
  I_CNAME               := 'testtest';
  I_CNAME_KANA          := 'testtest';
  I_ADDR                := '北海道';
  I_POST                := '7778888';
  I_TEL                 := '0311112222';
  I_BUSYO               := null;
  I_S_DATE              := 20101201000000;
  I_E_DATE              := 20101231235959;
  I_S_DATE_OP           := null;
  I_E_DATE_OP           := null;
  I_SALES_ID            := '90081';
  I_OTHER_MADDR         := null;
  I_END_FLG             := '0';
  I_USAGE               := null;
  I_POS                 := 1;
  I_CNT                 := 1;

  p_oauth_pkg.p_corp_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_PASSWD,
    I_CNAME,
    I_CNAME_KANA,
    I_ADDR,
    I_POST,
    I_TEL,
    I_BUSYO,
    I_S_DATE,
    I_E_DATE,
    I_S_DATE_OP,
    I_E_DATE_OP,
    I_SALES_ID,
    I_OTHER_MADDR,
    I_END_FLG,
    I_USAGE,
    I_POS,
    I_CNT,
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
  dbms_output.put_line('BUSYO='        || i_busyo);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALESID='      || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);

  if i_voskbn.count > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in i_voskbn.first..i_voskbn.last loop
      dbms_output.put_line(i_voskbn(i));
    end loop;
    dbms_output.put_line('-----------------------------------');
  end if;

  dbms_output.put_line('POS='        || i_pos);
  dbms_output.put_line('CNT='        || i_cnt);

  dbms_output.put_line('END_DT='     || o_end_dt);
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




-- **********************************
-- 削除テスト
-- **********************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN                 CHAR(1);
  I_UID                 VARCHAR2(15);
  I_CID                 VARCHAR2(16);
  I_PASSWD              VARCHAR2(10);
  I_CNAME               VARCHAR2(128);
  I_CNAME_KANA          VARCHAR2(128);
  I_ADDR                VARCHAR2(128);
  I_POST                VARCHAR2(7);
  I_TEL                 VARCHAR2(15);
  I_BUSYO               VARCHAR2(128);
  I_S_DATE              VARCHAR2(20);
  I_E_DATE              VARCHAR2(20);
  I_S_DATE_OP           VARCHAR2(20);
  I_E_DATE_OP           VARCHAR2(20);
  I_SALES_ID            VARCHAR2(5);
  I_OTHER_MADDR         VARCHAR2(1000);
  I_END_FLG             VARCHAR2(1);
  O_END_DT              VARCHAR2(20);
  I_USAGE               VARCHAR2(1024);
  I_VOSKBN              p_oauth_pkg.tbl_type;
  I_POS                 NUMBER;
  I_CNT                 NUMBER;
  O_INS_DT              VARCHAR2(20);
  O_UPD_DT              VARCHAR2(20);
  O_RTNCD               VARCHAR2(10);
  O_ERR_MSG             VARCHAR2(1000);
  O_CNT                 NUMBER;
  O_INFO                P_OAUTH_PKG.TBL_TYPE;

begin
  I_KBN                 := 'D';
  I_UID                 := null;
  I_CID                 := 'J002';
  I_PASSWD              := null;
  I_CNAME               := null;
  I_CNAME_KANA          := null;
  I_ADDR                := null;
  I_POST                := null;
  I_TEL                 := null;
  I_BUSYO               := null;
  I_S_DATE              := null;
  I_E_DATE              := null;
  I_S_DATE_OP           := null;
  I_E_DATE_OP           := null;
  I_SALES_ID            := null;
  I_OTHER_MADDR         := null;
  I_END_FLG             := null;
  I_USAGE               := null;
  I_POS                 := 1;
  I_CNT                 := 1;

  p_oauth_pkg.p_corp_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_PASSWD,
    I_CNAME,
    I_CNAME_KANA,
    I_ADDR,
    I_POST,
    I_TEL,
    I_BUSYO,
    I_S_DATE,
    I_E_DATE,
    I_S_DATE_OP,
    I_E_DATE_OP,
    I_SALES_ID,
    I_OTHER_MADDR,
    I_END_FLG,
    I_USAGE,
    I_POS,
    I_CNT,
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
  dbms_output.put_line('BUSYO='        || i_busyo);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALESID='      || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);

  if i_voskbn.count > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in i_voskbn.first..i_voskbn.last loop
      dbms_output.put_line(i_voskbn(i));
    end loop;
    dbms_output.put_line('-----------------------------------');
  end if;

  dbms_output.put_line('POS='        || i_pos);
  dbms_output.put_line('CNT='        || i_cnt);

  dbms_output.put_line('END_DT='     || o_end_dt);
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





-- **********************************
-- その他テスト
-- **********************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN                 CHAR(1);
  I_UID                 VARCHAR2(15);
  I_CID                 VARCHAR2(16);
  I_PASSWD              VARCHAR2(10);
  I_CNAME               VARCHAR2(128);
  I_CNAME_KANA          VARCHAR2(128);
  I_ADDR                VARCHAR2(128);
  I_POST                VARCHAR2(7);
  I_TEL                 VARCHAR2(15);
  I_BUSYO               VARCHAR2(128);
  I_S_DATE              VARCHAR2(20);
  I_E_DATE              VARCHAR2(20);
  I_S_DATE_OP           VARCHAR2(20);
  I_E_DATE_OP           VARCHAR2(20);
  I_SALES_ID            VARCHAR2(5);
  I_OTHER_MADDR         VARCHAR2(1000);
  I_END_FLG             VARCHAR2(1);
  O_END_DT              VARCHAR2(20);
  I_USAGE               VARCHAR2(1024);
  I_VOSKBN              p_oauth_pkg.tbl_type;
  I_POS                 NUMBER;
  I_CNT                 NUMBER;
  O_INS_DT              VARCHAR2(20);
  O_UPD_DT              VARCHAR2(20);
  O_RTNCD               VARCHAR2(10);
  O_ERR_MSG             VARCHAR2(1000);
  O_CNT                 NUMBER;
  O_INFO                P_OAUTH_PKG.TBL_TYPE;

begin
  I_KBN                 := 'K';
  I_UID                 := null;
  I_CID                 := 'J002';
  I_PASSWD              := null;
  I_CNAME               := null;
  I_CNAME_KANA          := null;
  I_ADDR                := null;
  I_POST                := null;
  I_TEL                 := null;
  I_BUSYO               := null;
  I_S_DATE              := null;
  I_E_DATE              := null;
  I_S_DATE_OP           := null;
  I_E_DATE_OP           := null;
  I_SALES_ID            := null;
  I_OTHER_MADDR         := null;
  I_END_FLG             := null;
  I_USAGE               := null;
  I_POS                 := 2;
  I_CNT                 := 1;

  p_oauth_pkg.p_corp_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_PASSWD,
    I_CNAME,
    I_CNAME_KANA,
    I_ADDR,
    I_POST,
    I_TEL,
    I_BUSYO,
    I_S_DATE,
    I_E_DATE,
    I_S_DATE_OP,
    I_E_DATE_OP,
    I_SALES_ID,
    I_OTHER_MADDR,
    I_END_FLG,
    I_USAGE,
    I_POS,
    I_CNT,
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
  dbms_output.put_line('BUSYO='        || i_busyo);
  dbms_output.put_line('S_DATE='       || i_s_date);
  dbms_output.put_line('E_DATE='       || i_e_date);
  dbms_output.put_line('S_DATE_OP='    || i_s_date_op);
  dbms_output.put_line('E_DATE_OP='    || i_e_date_op);
  dbms_output.put_line('SALESID='      || i_sales_id);
  dbms_output.put_line('OTHER_MADDR='  || i_other_maddr);
  dbms_output.put_line('END_FLG='      || i_end_flg);
  dbms_output.put_line('USAGE='        || i_usage);

  if i_voskbn.count > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in i_voskbn.first..i_voskbn.last loop
      dbms_output.put_line(i_voskbn(i));
    end loop;
    dbms_output.put_line('-----------------------------------');
  end if;

  dbms_output.put_line('POS='        || i_pos);
  dbms_output.put_line('CNT='        || i_cnt);

  dbms_output.put_line('END_DT='     || o_end_dt);
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


