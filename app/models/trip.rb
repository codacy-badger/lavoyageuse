class Trip < ApplicationRecord
  validates_presence_of :date
  validates_presence_of :host
  belongs_to :user
end
