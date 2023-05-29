# frozen_string_literal: true

class Message < ApplicationRecord
  # メッセージ作成してからmessage_broadcast_jobを動かすための記述
  after_create_commit { MessageBroadcastJob.perform_later self }

  belongs_to :user
  belongs_to :chatroom

  validates :content, presence: true

  # 未読メッセージをすべて返すメソッド。
  def self.unread_by(user)
    myjob_ids = Job.where(user_id: user.id).pluck(:id)
    chatrooms = Chatroom.where(job_id: myjob_ids).or(Chatroom.where(user_id: user.id)).where(hidden: false) # 自分のjobか自分がオファーしたもの、且つ非表示でないものを取得
    return Message.where(chatroom_id: chatrooms.ids).where.not(user_id: user.id).where(read_status: false)
  end
end
