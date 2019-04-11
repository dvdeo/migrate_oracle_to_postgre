-- *********************************
-- �����e�X�g�iUA�w��j
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'S';
  i_uid             := '00084';
  i_ua              := 'F-05D';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- �����e�X�g�iUA�w��Ȃ��j
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'S';
  i_uid             := '00084';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/


-- *********************************
-- �����e�X�g�iUA�w�� ��������v�j
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'S';
  i_uid             := '00084';
  i_ua              := 'F';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

  if o_cnt > 0 then
    dbms_output.put_line('-----------------------------------');
    for i in o_info.first..o_info.last loop
      dbms_output.put_line(o_info(i));
    end loop;
  end if;
end;
/

-- *********************************
-- �����e�X�g�iUA�Ȃ��j
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'S';
  i_uid             := '00084';
  i_ua              := 'aaaaaaaaaaaaaaa';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

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
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'I';
  i_uid             := '00084';
  i_ua              := 'test';
  i_val(1)          := 'model_name:nametest';
  i_val(2)          := 'voice_concier_draw_area_height:480';
  i_val(3)          := 'voice_concier_draw_area_width:320';
  i_val(4)          := 'dmn_app_mg:0';
  i_val(5)          := 'dmn_app_w:1';
  i_val(6)          := 'dmn_market_mg:A';
  i_val(7)          := 'dmn_market_w:A';
  i_val(8)          := 'dmn_device_type:P';
  i_val(9)          := 'town_transportation_flg:1';
  i_val(10)          := 'town_building_flg:1';
  i_val(11)          := 'valid_flg:1';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/



-- *********************************
-- �o�^�e�X�g(UA�L��G���[)
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'I';
  i_uid             := '00084';
  i_ua              := 'F-05D';
  i_val(1)          := 'model_name:test';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/

-- *********************************
-- �o�^�e�X�g(�����I�[�o�[)
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'I';
  i_uid             := '00084';
  i_ua              := 'test';
  i_val(1)          := 'model_name:nametest';
  i_val(2)          := 'voice_concier_draw_area_height:480';
  i_val(3)          := 'voice_concier_draw_area_width:320';
  i_val(4)          := 'dmn_app_mg:0';
  i_val(5)          := 'dmn_app_w:1';
  i_val(6)          := 'dmn_market_mg:A';
  i_val(7)          := 'dmn_market_w:A';
  i_val(8)          := 'dmn_device_type:P';
  i_val(9)          := 'town_transportation_flg:1';
  i_val(10)          := 'town_building_flg:11';
  i_val(11)          := 'valid_flg:1';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/


-- *********************************
-- �X�V�e�X�g
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'U';
  i_uid             := '00084';
  i_ua              := 'test';
  i_val(1)          := 'model_name:test2';
  i_val(2)          := 'carrier:010';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/


-- *********************************
-- �X�V�e�X�g(UA�����G���[)
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'U';
  i_uid             := '00084';
  i_ua              := 'aaaaaaaaaaaa';
  i_val(1)          := 'model_name:test2';
  i_val(2)          := 'carrier:010';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/


-- *********************************
-- �폜�e�X�g
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'D';
  i_uid             := '00084';
  i_ua              := 'test';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/

-- *********************************
-- �폜�e�X�g(UA�����G���[)
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'D';
  i_uid             := '00084';
  i_ua              := 'aaaaaaaaaaaaaa';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/


-- *********************************
-- �X�V�敪�G���[
-- *********************************
set pagesize 10000
set linesize 130
set serveroutput on
DECLARE
  i_kbn             char(1);
  i_uid             varchar2(5);
  i_ua              varchar2(100);
  i_val             p_smartphone_mst_pkg.tbl_type;
  o_rtncd           varchar2(10);
  o_err_msg         varchar2(200);
  o_cnt             number(5);
  o_info            p_smartphone_mst_pkg.tbl_type;

BEGIN
  i_kbn             := 'T';
  i_uid             := '00084';
  i_ua              := 'test';
  i_val(1)          := 'model_name:nametest';
  i_val(2)          := 'voice_concier_draw_area_height:480';
  i_val(3)          := 'voice_concier_draw_area_width:320';
  i_val(4)          := 'dmn_app_mg:0';
  i_val(5)          := 'dmn_app_w:1';
  i_val(6)          := 'dmn_market_mg:A';
  i_val(7)          := 'dmn_market_w:A';
  i_val(8)          := 'dmn_device_type:P';
  i_val(9)          := 'town_transportation_flg:1';
  i_val(10)          := 'town_building_flg:1';
  i_val(11)          := 'valid_flg:1';

p_smartphone_mst_pkg.p_smartphone_mst_upd(
  i_kbn,
  i_uid,
  i_ua,
  i_val,
  o_rtncd,
  o_err_msg,
  o_cnt,
  o_info
);

  dbms_output.put_line('KBN='         || i_kbn);
  dbms_output.put_line('UID='         || i_uid);
  dbms_output.put_line('UA ='         || i_ua);
  dbms_output.put_line('CNT='         || o_cnt);
  dbms_output.put_line('RTNCD='       || o_rtncd);
  dbms_output.put_line('ERRMSG='      || o_err_msg);

end;
/



