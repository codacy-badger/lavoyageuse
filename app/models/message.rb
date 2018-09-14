class Message < ApplicationRecord
  validates content, presence: true
  validates host, presence: true

  belongs_to user
end
