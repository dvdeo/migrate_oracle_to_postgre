--devpubdb�Ńe�X�g
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

--���ID,�N���C�A���gID�A���ԑS�Ă��������ꍇ
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


--���ID�N���C�A���gID�͐����������ԊO�̏ꍇ
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


--���ID���s���ȏꍇ
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



--���ID�A�N���C�A���gID��NULL�̏ꍇ
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



--�u'7001'�F���̑��G���[�v�̃e�X�g�̓v���V�[�W���X�N���v�g���A�e�X�g�p��update���̃R�����g�A�E�g���͂�����
-- �R���p�C�������s�Ńe�X�g�ł���

PUB: API20NINSYO> print rc

RC
--------------------------------
7001

PUB: API20NINSYO> print key

KEY
---------