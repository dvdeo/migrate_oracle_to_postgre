--devpubdb�Ńe�X�g
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

--���ID�A���t�@���[�A���ԑS�Ă��������ꍇ
variable rc char(4)
exec p_api20_ninsyo('TS','referer1',:rc)
print rc

PUB: API20NINSYO> print rc

RC
--------------------------------
0000


--���ID�A���t�@���[�͐����������ԊO�̏ꍇ
variable rc char(4)
exec p_api20_ninsyo('TestCGI1','referer1',:rc)
print rc

PUB: API20NINSYO> print rc

RC
--------------------------------
0002


--���ID���s���ȏꍇ
variable rc char(4)
exec p_api20_ninsyo('AAA','referer1',:rc)
print rc

PUB: API20NINSYO> print rc

RC
--------------------------------
0001


--���ID�A���t�@���[��NULL�̏ꍇ
variable rc char(4)
exec p_api20_ninsyo('','',:rc)
print rc

PUB: API20NINSYO> print rc

RC
--------------------------------
0001

--�u'7001'�F���̑��G���[�v�̃e�X�g�̓v���V�[�W���X�N���v�g���A�e�X�g�p��update���̃R�����g�A�E�g���͂�����
-- �R���p�C�������s�Ńe�X�g�ł���



