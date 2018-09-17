class User < ApplicationRecord
  enum role: { member: 0, premium: 1, moderator: 2, admin: 3}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :phone
  validates_length_of :phone, minimum: 10
  validates_presence_of :address
  validates_presence_of :birth_date
  # validates_presence_of :photo
  # validates_presence_of :identity_card

  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :trips, dependent: :destroy

  # geocoded_by :address
  # after_validation :geocode, if: :address_changed?

  def full_name
    "#{first_name} #{last_name}"
  end

  # def gmap_hash(users)
  #   Gmaps4rails.build_markers(users) do |user, marker|
  #     marker.lat user.latitude
  #     marker.lng user.longitude
  #     marker.infowindow user.company
  #     marker.picture({
  #       url: user.marker_picture(self),
  #       width: 32,
  #       height: 32,
  #       })
  #   end
  # end

end
