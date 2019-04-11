var rc number
execute mail_sender('hosoya@mailsys.its-mo.com','hosoya@zenrin-datacom.net','test','test',:rc,'hosoya@mailsys.its-mo.com','JA16SJIS','Shift-JIS');
print rc;


declare
  mlsvr varchar2(40) := '172.24.200.220';     -- メールサーバ名、または、IP
   smtp_port     varchar2(10)    := '25';
 mlfr  varchar2(40) := 'hosoya@mailsys.its-mo.com'; -- 発信元メールアドレス
  mlto  varchar2(40);
  mlsub varchar2(80);
  mlmsg varchar2(2000);
  smtp  utl_smtp.connection;
begin

-- メールデータセット
  mlto  := 'hosoya@zenrin-datacom.net';                   -- 送信先メールアドレス
  mlsub := 'title';                            -- メールタイトル
  mlmsg := 'mail body' || chr(13) || chr(10);  -- メール本文
  mlmsg := mlmsg || '0123456789' || chr(13) || chr(10);
  mlmsg := mlmsg || 'abcdefg' || chr(13) || chr(10);

-- メール送信
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