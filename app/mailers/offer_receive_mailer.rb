class OfferReceiveMailer < ApplicationMailer
  def send_mail(from,job,content)
    @from = from
    @content = content
    @job = job
    @url  = 'https://part-ner.net/offers'
    mail to: job.user.email,
    subject: "【Part-ner】あなたの募集にオファーが届きました!【#{job.tytle}】"
  end
end
