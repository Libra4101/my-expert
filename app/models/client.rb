class Client < ApplicationRecord
  # devise setting
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable,
         omniauth_providers: %i[facebook google_oauth2]

  # image
  attachment :avater_image

  # association
  has_many :favorites, dependent: :destroy
  has_many :favorite_experts, through: :favorites
  has_many :problems
  has_many :consultations
  has_many :consultations_event, through: :consultations

  # validate
  validates :name,          presence: true, length: { maximum: 60 }
  validates :name_kana,     length: { maximum: 75 }
  validates :phone_number,  length: { maximum: 25 }
  validates :address,       length: { maximum: 160 }

  # enum
  enum gender: { sex_not_known: 0, male: 1, female: 2 }

  # SNS認証
  def self.find_for_oauth(auth)
    client = Client.where(uid: auth.uid, provider: auth.provider).first
    unless client
      client = Client.new(
        name:     auth.info.name,
        uid:      auth.uid,
        provider: auth.provider,
        email:    Client.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
      client.skip_confirmation!
      client.save!
    end
    return client
  end
  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end