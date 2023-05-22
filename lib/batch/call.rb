class Batch::Call
  def self.call
    users = User.all
    users.each do |user|
      @offers = Offer.where(job_id: user.jobs.ids) #自分に届いたオファー
      @messages = Message.unread_by(user) #未読かつ非表示でないメッセージ

      if @offers.exists? or @messages.exists? #↑これらが存在する時にメールを送信
        @user = user
        UserCallMailer.send_mail(@user, @offers, @messages).deliver
        p "メールを送りました"
      end
    end
  end
end