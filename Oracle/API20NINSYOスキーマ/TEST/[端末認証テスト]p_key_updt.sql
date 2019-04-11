-- ******************************************
-- 複数件検索テスト（CID,クライアントID指定無し）
-- ******************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CID             varchar2(15);
  I_KEY_NUM         varchar2(116);
  I_CONSUMER_ID     varchar2(100);
  I_SERVICE_NAME    varchar2(300);
  I_KEY             varchar2(116);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            P_OAUTH_PKG.tbl_type;

begin
  I_KBN             := 'S';
  I_UID             := 'ebi';
--  I_CID           := null;
  I_CID             := 'J002';
  I_KEY_NUM         := 3;
  I_CONSUMER_ID     := null;
  I_SERVICE_NAME    := null;
  I_KEY             := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_key_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_KEY_NUM,
    I_CONSUMER_ID,
    I_SERVICE_NAME,
    I_KEY,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CID='         || I_CID);
  dbms_output.put_line('CONSUMER_ID=' || I_CONSUMER_ID);
  dbms_output.put_line('SERVICE_NAME='|| I_SERVICE_NAME);
  dbms_output.put_line('KEY='         || I_KEY);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);

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



-- ******************************************
-- １件検索テスト（CID,クライアントID指定）
-- ******************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CID             varchar2(15);
  I_KEY_NUM         varchar2(116);
  I_CONSUMER_ID     varchar2(100);
  I_SERVICE_NAME    varchar2(300);
  I_KEY             varchar2(116);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            P_OAUTH_PKG.tbl_type;

begin
  I_KBN             := 'S';
  I_UID             := 'ebi';
--  I_CID           := null;
  I_CID             := 'J001';
  I_KEY_NUM         := 4;
  I_CONSUMER_ID     := '0001';
  I_SERVICE_NAME    := null;
  I_KEY             := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_key_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_KEY_NUM,
    I_CONSUMER_ID,
    I_SERVICE_NAME,
    I_KEY,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CID='         || I_CID);
  dbms_output.put_line('CONSUMER_ID=' || I_CONSUMER_ID);
  dbms_output.put_line('SERVICE_NAME='|| I_SERVICE_NAME);
  dbms_output.put_line('KEY='         || I_KEY);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);

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





-- ******************************************
-- 登録テスト
-- ******************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CID             varchar2(15);
  I_KEY_NUM         varchar2(116);
  I_CONSUMER_ID     varchar2(100);
  I_SERVICE_NAME    varchar2(300);
  I_KEY             varchar2(116);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            P_OAUTH_PKG.tbl_type;

begin
  I_KBN             := 'I';
  I_UID             := 'ebi';
--  I_CID           := null;
  I_CID             := 'J002';
  I_KEY_NUM         := null;
  I_CONSUMER_ID     := '0002';
  I_SERVICE_NAME    := null;
  I_KEY             := 'zzz';
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_key_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_KEY_NUM,
    I_CONSUMER_ID,
    I_SERVICE_NAME,
    I_KEY,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CID='         || I_CID);
  dbms_output.put_line('CONSUMER_ID=' || I_CONSUMER_ID);
  dbms_output.put_line('SERVICE_NAME='|| I_SERVICE_NAME);
  dbms_output.put_line('KEY='         || I_KEY);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);

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






-- ******************************************
-- 更新テスト
-- ******************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CID             varchar2(15);
  I_KEY_NUM         varchar2(116);
  I_CONSUMER_ID     varchar2(100);
  I_SERVICE_NAME    varchar2(300);
  I_KEY             varchar2(116);
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
--  I_CID           := null;
  I_CID             := 'J001';
  I_KEY_NUM         := 3;
  I_CONSUMER_ID     := '1111';
  I_SERVICE_NAME    := null;
  I_KEY             := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_key_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_KEY_NUM,
    I_CONSUMER_ID,
    I_SERVICE_NAME,
    I_KEY,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CID='         || I_CID);
  dbms_output.put_line('CONSUMER_ID=' || I_CONSUMER_ID);
  dbms_output.put_line('SERVICE_NAME='|| I_SERVICE_NAME);
  dbms_output.put_line('KEY='         || I_KEY);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);

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



-- ******************************************
-- 削除テスト
-- ******************************************
set pagesize 10000
set linesize 130
set serveroutput on
declare
  I_KBN             char(1);
  I_UID             varchar2(15);
  I_CID             varchar2(15);
  I_KEY_NUM         varchar2(116);
  I_CONSUMER_ID     varchar2(100);
  I_SERVICE_NAME    varchar2(300);
  I_KEY             varchar2(116);
  I_POS             number;
  I_CNT             number;
  O_INS_DT          varchar2(20);
  O_UPD_DT          varchar2(20);
  O_RTNCD           varchar2(10);
  O_ERR_MSG         varchar2(1000);
  O_CNT             number;
  O_INFO            P_OAUTH_PKG.tbl_type;

begin
  I_KBN             := 'D';
  I_UID             := 'ebi';
--  I_CID           := null;
  I_CID             := 'J001';
  I_KEY_NUM         := 4;
  I_CONSUMER_ID     := '1111';
  I_SERVICE_NAME    := null;
  I_KEY             := null;
  I_POS             := 1;
  I_CNT             := 100;

  p_oauth_pkg.p_key_updt(
    I_KBN,
    I_UID,
    I_CID,
    I_KEY_NUM,
    I_CONSUMER_ID,
    I_SERVICE_NAME,
    I_KEY,
    I_POS,
    I_CNT,
    O_INS_DT,
    O_UPD_DT,
    O_RTNCD,
    O_ERR_MSG,
    O_CNT,
    O_INFO
  );

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('CID='         || I_CID);
  dbms_output.put_line('CONSUMER_ID=' || I_CONSUMER_ID);
  dbms_output.put_line('SERVICE_NAME='|| I_SERVICE_NAME);
  dbms_output.put_line('KEY='         || I_KEY);
  dbms_output.put_line('POS='         || i_pos);
  dbms_output.put_line('CNT='         || i_cnt);

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
