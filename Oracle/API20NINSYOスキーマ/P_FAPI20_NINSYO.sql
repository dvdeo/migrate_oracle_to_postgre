CREATE OR REPLACE PROCEDURE "API20NINSYO".p_fapi20_ninsyo (
    i_cid      in  varchar2,      -- 企業ID
    i_referer  in  varchar2,      -- リファラー
    o_rtncd    out char,          -- リターンコード
                                  --    '0000'：正常終了（認証ＯＫ）
                                  --    '0001'：認証エラー
                                  --    '0002'：利用期間外エラー
                                  --    '7001'：その他エラー
    o_referer  out char           -- 登録済みリファラー(複数ある場合は最も長いもの)
) IS
    -- API認証テーブルカーソル
    CURSOR auth_cur(i_cid varchar2, i_referer varchar2) IS
        select cid,
               referer,
               -- サービス期間チェック（1:期間内、0:期間外）
               case
                 when trunc(sysdate) between trunc(s_date) and trunc(e_date) then '1'
                 else '0'
               end srv_date_flg
        from  fauth_mview
        where cid = i_cid
        and   instr(i_referer ,replace(referer,'*','') ) = 1     -- リファラーに*が含まれていても前方一致
                                                                 -- 例)登録済みリファラー「http://xx-xxx/*」の場合、「http://xx-xxx/yyy」でも認証可
        order by length(referer) desc;

    auth_rec    auth_cur%ROWTYPE;
    rtncd       char(4);      -- リターンコード
    referer     varchar2(100);  -- 返却リファラー

BEGIN
    rtncd    := null;

    OPEN auth_cur(i_cid, i_referer);
    FETCH auth_cur INTO auth_rec;

    if auth_cur%NOTFOUND then            --認証エラー(企業ID or リファラー不一致)
        rtncd   := '0001';
        referer := null;
    else
      if auth_rec.srv_date_flg = '0'  then     -- 利用期間外エラー
          rtncd   := '0002';
          referer := null;
      else
          rtncd   := '0000';
          referer := auth_rec.referer;
      end if;
    end if;

    CLOSE auth_cur;

    --'7001'：その他エラー テスト用
    --update fauth_mview set cid = 'BBB' where cid = 'TestCGI1';

    o_rtncd   := rtncd;
    o_referer := referer;
EXCEPTION
    when others then
        o_rtncd  := '7001';
        o_referer := '';
END;