CREATE OR REPLACE PROCEDURE "API20NINSYO".p_api20_ninsyo_noref (
    i_cid      in  varchar2,      -- 企業ID
    o_rtncd    out char           -- リターンコード
                                  --    '0000'：正常終了（認証ＯＫ）
                                  --    '0001'：企業IDなしエラー
                                  --    '0002'：利用期間外エラー
                                  --    '7001'：その他エラー
) IS
    -- API認証テーブルカーソル
    CURSOR auth_cur(i_cid varchar2) IS
        select cid,
               -- サービス期間チェック（1:期間内、0:期間外）
               case
                 when trunc(sysdate) between trunc(s_date) and trunc(e_date) then '1'
                 else '0'
               end srv_date_flg
        from  auth_noref_mview
        where cid = i_cid;

    auth_rec    auth_cur%ROWTYPE;
    rtncd       char(4);      -- リターンコード

BEGIN
    rtncd    := null;

    OPEN auth_cur(i_cid);
    FETCH auth_cur INTO auth_rec;

    if auth_cur%NOTFOUND then                  -- 企業IDなしエラー
        rtncd  := '0001';
    else
      if auth_rec.srv_date_flg = '0'  then     -- 利用期間外エラー
          rtncd   := '0002';
      else
          rtncd   := '0000';
      end if;
    end if;

    CLOSE auth_cur;

    --'7001'：その他エラー テスト用
    --update auth_mview set cid = 'BBB' where cid = 'TestCGI1';

    o_rtncd  := rtncd;
EXCEPTION
    when others then
        o_rtncd  := '7001';
END;