class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  enum role: {visitor: 0, member: 1, suspended: 2}
  enum host: {not_host: 0, unvalidated_host: 1, validated_host: 2}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_format_of :password, with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}\Z/, if: :email_changed?

  validates :email, presence: { message: 'ne peut pas être vide' },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates_presence_of :first_name, :last_name, :phone, :photo, :address, :birth_date, :sentence
  validates_length_of :phone, minimum: 10
  validates :home, length: { minimum: 10, too_short: "%{count} est le minimum pour la description de votre hébergement" }, allow_blank: true
  validates_processing_of :photo
  validate :image_size_validation

  has_many :posted_messages, class_name: "Message", foreign_key: "traveller_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "host_id", dependent: :destroy

  has_many :posted_comments, class_name: "Comment", foreign_key: "traveller_id",dependent: :destroy
  has_many :received_comments, class_name: "Comment", foreign_key: "host_id",dependent: :destroy

  has_many :announced_trips, class_name: "Trip", foreign_key: "traveller_id", dependent: :destroy
  has_many :announced_hostings, class_name: "Trip", foreign_key: "host_id", dependent: :destroy

  has_many :moderation_done, class_name: "Moderation", foreign_key: "moderator_id"
  has_many :moderation_suffered, class_name: "Moderation", foreign_key: "moderated_id"

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  scope :hosts, -> { where(host: [1,2], role:1) }
  scope :not_hosts, -> { where(host: 0, role:1) }
  scope :unvalidated_members, -> { where(role: 0) }
  scope :suspended_members, -> { where(role: 2) }
  scope :premium, -> { where(premium: true)}
  scope :all_except, ->(user) { where.not(id: user) }

  def name
    "#{id} - #{first_name} #{last_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def hidden_full_name
    "#{first_name} #{last_name[0]}".split.map(&:capitalize).join(" ") + "."
  end

  def not_accessible
    not_host? || suspended?
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
