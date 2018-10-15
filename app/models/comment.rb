class Comment < ApplicationRecord
  validates_presence_of :content
  belongs_to :traveller, class_name: "User"
  belongs_to :host, class_name: "User"
end
