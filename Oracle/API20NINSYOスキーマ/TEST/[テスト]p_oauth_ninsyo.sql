--devpubdbでテスト
connect api20ninsyo/api20ninsyo

set lines 200
col REFERER format a20
select * from oauth_mview

CID        CONSUMER_I KEY        S_DATE   E_DATE   R_ROWID            C_ROWID
---------- ---------- ---------- -------- -------- ------------------ ------------------
J001       0001       zzz        12-11-12 12-12-31 AAAJX3AAFAAAAJOAAA AAAJX1AAFAAAAI+AAA
J001       0002       zzz        12-11-12 12-12-31 AAAJX3AAFAAAAJOAAB AAAJX1AAFAAAAI+AAA
J001       0004       xxx        12-11-12 12-12-31 AAAJX3AAFAAAAJPAAA AAAJX1AAFAAAAI+AAA
J001       1111       yyy        12-11-12 12-12-31 AAAJX3AAFAAAAJPAAB AAAJX1AAFAAAAI+AAA
J002       0002       zzz        10-12-01 10-12-01 AAAJX3AAFAAAAJOAAC AAAJX1AAFAAAAI+AAB
J002       0005       aaa        10-12-01 10-12-01 AAAJX3AAFAAAAJPAAC AAAJX1AAFAAAAI+AAB

--企業ID,クライアントID、期間全てが正しい場合
variable rc char(4)
variable key varchar2(100)
exec p_oauth_ninsyo('J0010001',:rc,:key)
print rc
print key

PUB: API20NINSYO> print rc

RC
--------------------------------
0000

PUB: API20NINSYO> print key

KEY
----------
zzz


--企業IDクライアントIDは正しいが期間外の場合
variable rc char(4)
variable key varchar2(100)
exec p_oauth_ninsyo('J0020005',:rc,:key)
print rc
print key


PUB: API20NINSYO> print rc

RC
--------------------------------
0002

PUB: API20NINSYO> print key

KEY
----------


--企業IDが不正な場合
variable rc char(4)
variable key varchar2(100)
exec p_oauth_ninsyo('JJJJ0005',:rc,:key)
print rc
print key


PUB: API20NINSYO> print rc

RC
--------------------------------
0001

PUB: API20NINSYO> print key

KEY
----------



--企業ID、クライアントIDがNULLの場合
variable rc char(4)
variable key varchar2(100)
exec p_oauth_ninsyo('',:rc,:key)
print rc
print key

PUB: API20NINSYO> print rc

RC
--------------------------------
0001

PUB: API20NINSYO> print key

KEY
----------



--「'7001'：その他エラー」のテストはプロシージャスクリプト内、テスト用のupdate文のコメントアウトをはずして
-- コンパイル→実行でテストできる

PUB: API20NINSYO> print rc

RC
--------------------------------
7001

PUB: API20NINSYO> print key

KEY
---------