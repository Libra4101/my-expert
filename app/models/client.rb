class Client < ApplicationRecord
  # devise setting
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[google_oauth2]

  # image
  attachment :avater_image

  # association
  has_many :favorites, dependent: :destroy
  has_many :favorite_experts, through: :favorites, source: 'expert'
  has_many :problems
  has_many :consultations
  has_many :events, through: :consultations
  has_many :comments, class_name: 'Comment', foreign_key: 'client_id'

  # validate
  validates :name,          presence: true, length: { maximum: 60 }
  validates :name_kana,     length: { maximum: 75 }
  validates :email,         uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :postcode,      format: { with:/\A\d{3}-?\d{4}\z/}, allow_blank: true
  validates :phone_number,  format: { with:/\A\d{3,4}-?\d{2,4}-?\d{4}\z/}, allow_blank: true
  validates :address,       length: { maximum: 160 }
  validates :age,           numericality: { only_integer: true }, allow_blank: true

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
        email:    (auth.info.email || Client.dummy_email(auth)),
        password: Devise.friendly_token[0, 20]
      )
      # client.skip_confirmation!
      client.save!
    end
    return client
  end

  # 退会ステータス名称を表示
  def withdraw_status_name
    self.withdraw_status ? "登録中" : "退会済"
  end

  # 退会確認
  def active_for_authentication?
    super && self.withdraw_status
  end

  # 退会済みエラーメッセージを表示
  def inactive_message
    self.withdraw_status ? super : :deleted_account
  end

  # ゲスト会員
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |client|
      client.password = SecureRandom.urlsafe_base64
      client.name = '山田太郎'
      client.name_kana = 'ヤマダタロウ'
      client.gender = 1
      client.age = '35'
      client.address = '大阪府泉大津市池浦町'
      client.postcode = '595-0022'
      client.phone_number = '090-999-9999'
    end
  end

  private

  # ダミーメールアドレス
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
