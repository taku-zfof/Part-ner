class OfferOkMailer < ApplicationMailer
  def send_mail(user,job)
    @user = user
    @job = job
    @url  = 'https://part-ner.net/chatrooms'
    mail to: user.email,
    subject: "【Part-ner】あなたのオファーが承認されました!【#{job.tytle}】"
  end
end
