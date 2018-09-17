class Message < ApplicationRecord
  validates_presence_of :content
  validates_presence_of :host

  belongs_to :user
end
