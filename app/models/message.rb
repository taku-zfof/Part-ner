class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
  
  def self.unread_by(user)
    myjob_ids = Job.where(user_id: user.id).pluck(:id)
    chatrooms = Chatroom.where(job_id: myjob_ids).or(Chatroom.where(user_id: user.id))
    return Message.where(chatroom_id: chatrooms.ids).where.not(user_id: user.id).where(read_status: false)
  end
end
