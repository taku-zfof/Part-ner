# frozen_string_literal: true

class UserCallMailer < ApplicationMailer
  def send_mail(user,offers,messages)
    @user = user
    @offers_count = offers.count
    @messages_count = messages.count
    @url = "https://part-ner.net/users/sign_in"

    mail to: user.email,
    subject: "【Part-ner】未確認の通知があります"
  end
end
