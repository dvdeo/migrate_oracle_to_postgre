CREATE OR REPLACE PROCEDURE "API20NINSYO".p_del_fapi20_proreg
( o_rtncd    out    number)
IS
    w_rtncd number;
BEGIN
    o_rtncd := 0;

    delete from fapi20_proreg_tbl
    where upd_dt < sysdate -1/24 ;
    commit;

EXCEPTION
    when others then
      rollback;
      o_rtncd :=sqlcode;
END;