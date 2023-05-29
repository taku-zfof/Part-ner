# frozen_string_literal: true

class Offer < ApplicationRecord
 belongs_to :user
 belongs_to :job
end
