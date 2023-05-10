class Chatroom < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_many :messages, dependent: :destroy

  # そのチャットルーム内の未読メッセージを取得
  def unread_messages(user)
    return self.messages.where.not(user_id: user.id).where(read_status: false)
  end

  # ユーザーがオファーしたものor自分の仕事に紐づいてるチャットルームをすべて取得
  def self.selfchat(user)
    myjob_ids = Job.where(user_id: user.id).pluck(:id)
    return Chatroom.where(job_id: myjob_ids).or(Chatroom.where(user_id: user.id))
  end
end
