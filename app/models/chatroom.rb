class Chatroom < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_many :messages
end
