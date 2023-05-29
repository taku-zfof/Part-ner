# frozen_string_literal: true

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
  
  before_create :set_rondom_id # ユーザー作成時に以下のアクション
  # rondom_idが空か、同じrondom_idのユーザーが存在する時にランダムな文字列を代入する
    def set_rondom_id
      while self.rondom_id.blank? || Chatroom.find_by(rondom_id: self.rondom_id).present? do
        self.rondom_id = SecureRandom.base36
      end
    end
    def to_param
       rondom_id
    end

end
