--devpubdbでテスト
connect api20ninsyo/api20ninsyo

set lines 200
col REFERER format a20
select * from auth_mview;

CID             REFERER              S_DATE   E_DATE   R_ROWID            C_ROWID
--------------- -------------------- -------- -------- ------------------ ------------------
TS              referer1             11-03-22 11-04-21 AAAmC9AAQAAAAAfAAE AAAmC7AAQAAAAAQAAA
TS              referer2             11-03-22 11-04-21 AAAmC9AAQAAAAAfAAF AAAmC7AAQAAAAAQAAA
TS              referer3             11-03-22 11-04-21 AAAmC9AAQAAAAAfAAA AAAmC7AAQAAAAAQAAA
TestCGI1        referer4             07-11-05 09-06-17 AAAmC9AAQAAAAAgAAC AAAmC7AAQAAAAANAAA
TestCGI1        referer1             07-11-05 09-06-17 AAAmC9AAQAAAAAgAAD AAAmC7AAQAAAAANAAA

--企業ID、リファラー、期間全てが正しい場合
variable rc char(4)
exec p_api20_ninsyo('TS','referer1',:rc)
print rc

PUB: API20NINSYO> print rc

RC
--------------------------------
0000


--企業ID、リファラーは正しいが期間外の場合
variable rc char(4)
exec p_api20_ninsyo('TestCGI1','referer1',:rc)
print rc

PUB: API20NINSYO> print rc

RC
--------------------------------
0002


--企業IDが不正な場合
variable rc char(4)
exec p_api20_ninsyo('AAA','referer1',:rc)
print rc

PUB: API20NINSYO> print rc

RC
--------------------------------
0001


--企業ID、リファラーがNULLの場合
variable rc char(4)
exec p_api20_ninsyo('','',:rc)
print rc

PUB: API20NINSYO> print rc

RC
--------------------------------
0001

--「'7001'：その他エラー」のテストはプロシージャスクリプト内、テスト用のupdate文のコメントアウトをはずして
-- コンパイル→実行でテストできる



