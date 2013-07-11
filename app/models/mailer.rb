# -*- encoding : utf-8 -*-
class Mailer < ActionMailer::Base
  def padrao(corpo, assunto,email_to,email_from)
    recipients email_to
    from 'deivisson@siematec.com.br'
    subject assunto
    reply_to email_from
    body :corpo => corpo
  end
end
