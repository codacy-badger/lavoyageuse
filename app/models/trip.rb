class Trip < ApplicationRecord
  validates_presence_of :date
  belongs_to :traveller
  belongs_to :host
end
