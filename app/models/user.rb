class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  enum role: { member: 0, premium: 1, moderator: 2, admin: 3}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_format_of :password, with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}\Z/

  validates :email, presence: { message: 'ne peut pas être vide' },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates_presence_of :first_name, :last_name, :phone, :photo, :address, :birth_date
  validates_length_of :phone, minimum: 10
  validates_processing_of :photo
  validate :image_size_validation

  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :trips, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def full_name
    "#{first_name} #{last_name}"
  end

  def hidden_full_name
    "#{first_name} #{last_name[0]}".split.map(&:capitalize).join(" ") + "."
  end

  def gmap_hash(users)
    Gmaps4rails.build_markers(users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.company
      marker.picture({
        url: user.marker_picture(self),
        width: 32,
        height: 32,
        })
    end
  end

  private

  def image_size_validation
    errors[:photo] << "should be less than 2mo" if photo.size > 2.megabytes
  end

end
