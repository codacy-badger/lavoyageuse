class Trip < ApplicationRecord
  validates_presence_of :beginning, :end
  belongs_to :traveller, class_name: "User"
  belongs_to :host, class_name: "User"
end
