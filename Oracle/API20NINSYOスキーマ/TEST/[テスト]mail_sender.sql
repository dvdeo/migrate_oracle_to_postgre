var rc number
execute mail_sender('hosoya@mailsys.its-mo.com','hosoya@zenrin-datacom.net','test','test',:rc,'hosoya@mailsys.its-mo.com','JA16SJIS','Shift-JIS');
print rc;


declare
  mlsvr varchar2(40) := '172.24.200.220';     -- ���[���T�[�o���A�܂��́AIP
   smtp_port     varchar2(10)    := '25';
 mlfr  varchar2(40) := 'hosoya@mailsys.its-mo.com'; -- ���M�����[���A�h���X
  mlto  varchar2(40);
  mlsub varchar2(80);
  mlmsg varchar2(2000);
  smtp  utl_smtp.connection;
begin

-- ���[���f�[�^�Z�b�g
  mlto  := 'hosoya@zenrin-datacom.net';                   -- ���M�惁�[���A�h���X
  mlsub := 'title';                            -- ���[���^�C�g��
  mlmsg := 'mail body' || chr(13) || chr(10);  -- ���[���{��
  mlmsg := mlmsg || '0123456789' || chr(13) || chr(10);
  mlmsg := mlmsg || 'abcdefg' || chr(13) || chr(10);

-- ���[�����M
  smtp := utl_smtp.open_connection(mlsvr, smtp_port);
  utl_smtp.helo(smtp, mlsvr);
  utl_smtp.mail(smtp, mlfr);
  utl_smtp.rcpt(smtp, mlto);
  utl_smtp.data(smtp,
    'To:' || mlto || chr(13) || chr(10) ||
    'From:' || mlfr || chr(13) || chr(10) ||
    'Subject:' || mlsub || chr(13) || chr(10) ||
    chr(13) || chr(10) || mlmsg
  );
  utl_smtp.quit(smtp);

end;
/