class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  mount_uploader :id_card, CardUploader
  enum role: {visitor: 0, member: 1}
  enum host: {not_host: 0, unvalidated_host: 1, validated_host: 2}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :campaignable

  validates_format_of :password, with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}\Z/, if: :email_changed?

  validates :email, presence: { message: 'ne peut pas être vide' },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates_presence_of :first_name, :last_name, :phone, :photo, :id_card, :address, :sentence
  validates :home, length: { minimum: 30, too_short: "%{count} est le minimum pour la description de votre hébergement" }, allow_blank: true
  validates_processing_of :photo
  validates_processing_of :id_card
  validate :image_size_validation
  validates :adulthood, acceptance: { message: 'vous devez être majeure pour vous inscrire sur La Voyageuse'}, on: :create
  validates :womanhood, acceptance: { message: 'vous devez être une femme pour vous inscrire sur La Voyageuse'}, on: :create

  has_many :posted_messages, class_name: "Message", foreign_key: "traveller_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "host_id", dependent: :destroy

  has_many :posted_comments, class_name: "Comment", foreign_key: "traveller_id",dependent: :destroy
  has_many :received_comments, class_name: "Comment", foreign_key: "host_id",dependent: :destroy

  has_many :announced_trips, class_name: "Trip", foreign_key: "traveller_id", dependent: :destroy
  has_many :announced_hostings, class_name: "Trip", foreign_key: "host_id", dependent: :destroy

  has_many :moderation_done, class_name: "Moderation", foreign_key: "moderator_id"
  has_many :moderation_suffered, class_name: "Moderation", foreign_key: "moderated_id"

  has_many :orders

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_validation :suspension, if: :suspended_changed?
  after_create :unsubscribe_to_mailchimp
  before_update :unvalidation, if: :personal_datas_changed?
  before_create :set_edition_delay

  scope :possible_hosts, -> { where(host: [1,2], role:1) }
  scope :not_hosts, -> { where(host: 0, role:1) }
  scope :suspended, -> { where(suspended: true) }
  scope :premium, -> { where(premium: true, role: 1)}
  scope :all_except, ->(user) { where.not(id: user) }
  scope :mappable, -> { where.not(latitude: nil, longitude: nil)}

  def full_name
    "#{first_name} #{last_name}"
  end

  def hidden_full_name
    "#{first_name} #{last_name[0]}".split.map(&:capitalize).join(" ") + "."
  end

  def not_accessible
    not_host? || suspended
  end

  def self.reported
    where(reported: true)
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

  def suspension
    UserMailer.custom_mail({ subject: suspended ? I18n.t('user.subject_suspension') : I18n.t('user.subject_unsuspension'),
                              email: "test@la-voyageuse.com",
                              btn_text: suspended ? I18n.t('user.btn_text_mail_to') : I18n.t('user.btn_text_website'),
                              btn_link: suspended ? "mailto:hello@la-voyageuse.com" : "https://www.la-voyageuse.com",
                              photo: suspended ? "https://res.cloudinary.com/dfcsmghw4/image/upload/v1543425652/transactional/photo-1530041686259-53d26f863313.jpg" : "https://res.cloudinary.com/dfcsmghw4/image/upload/v1543439458/transactional/photo-1482849297070-f4fae2173efe.jpg",
                              content: suspended ? I18n.t('user.content_message_suspension') : I18n.t('user.content_message_unsuspension')}).deliver_now
  end

  private

  def unvalidation
    self.role = "visitor"
    set_edition_delay
  end

  def set_edition_delay
    self.edition_delay = DateTime.now.next_month(3)
  end

  def unsubscribe_to_mailchimp
    self.unsubscribe unless self.newsletter
  end

  def personal_datas_changed?
    first_name_changed? || last_name_changed? || address_changed? || phone_changed? || photo_changed? || id_card_changed?
  end

  def image_size_validation
    errors[:photo] << "should be less than 2mo" if photo.size > 2.megabytes
  end

end
