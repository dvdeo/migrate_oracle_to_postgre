CREATE OR REPLACE PROCEDURE "API20NINSYO".p_oauth_ninsyo (
    i_id           in  varchar2,      -- 企業ID
    o_rtncd        out char,          -- リターンコード
                                      --    '0000'：正常終了（認証ＯＫ）
                                      --    '0001'：認証エラー
                                      --    '0002'：利用期間外エラー
                                      --    '7001'：その他エラー
    o_key          out varchar2       -- 秘密鍵の設定(リターンコード'0000'の場合に返却)
) IS
    -- 認証テーブルカーソル
    CURSOR auth_cur(i_id varchar2) IS
        select cid,
               consumer_id,
               cid||consumer_id srch,
               key,
               -- サービス期間チェック（1:期間内、0:期間外）
               case
                 when trunc(sysdate) between trunc(s_date) and trunc(e_date) then '1'
                 else '0'
               end srv_date_flg
        from  oauth_mview
        where cid||consumer_id = i_id;

    auth_rec    auth_cur%ROWTYPE;
    rtncd       char(4);      -- リターンコード

BEGIN
    rtncd    := null;
    o_key    := null;

    OPEN auth_cur(i_id);
    FETCH auth_cur INTO auth_rec;

    if auth_cur%NOTFOUND then                  --認証エラー(企業ID or クライアントID不一致)
        rtncd  := '0001';
    else
      if auth_rec.srv_date_flg = '0'  then     -- 利用期間外エラー
          rtncd   := '0002';
      else
          rtncd   := '0000';
          o_key   := auth_rec.key;
      end if;
    end if;

    CLOSE auth_cur;

    --'7001'：その他エラー テスト用
    --update oauth_mview set cid = 'BBB' where cid = 'TestCGI1';

    o_rtncd  := rtncd;
EXCEPTION
    when others then
        o_rtncd  := '7001';
END;