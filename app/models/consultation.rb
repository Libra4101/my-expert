class Consultation < ApplicationRecord
  # association
  belongs_to :client
  belongs_to :expert
  belongs_to :trouble_tag
  belongs_to :event, optional: true

  attr_accessor :password, :event_time

  # enum
  enum reservation_status: { applying: 0, reservations: 1, completed: 2 }

  # validate
  validates :trouble_tag_id, presence: true
  validates :client_id, presence: true
  validates :expert_id, presence: true
  validates :event_id, presence: true, unless: -> { validation_context == :new_save }
  validates :event_time, presence: true
  validate :datetime_format_valid, if: -> {self.event_time.present?}
  validate :datetime_correlation_valid, if: -> {self.event_time.present?}
  validates :content, presence: true, length: { maximum: 2500 }

  # 相談内容検索
  def self.search(keyword)
    return Consultation.all unless keyword
    Consultation.where('content LIKE ?', "%#{sanitize_sql_like(keyword)}%")
  end

  private

  # 予約日時形式チェック
  def datetime_format_valid
    errors.add(:event_time, 'はyyyy/mm/dd hh:mmの形式で入力してください。') unless !! Time.zone.parse(self.event_time) rescue false
  end

  # 予約日時相関チェック
  def datetime_correlation_valid
    user_datetime = Date.parse(self.event_time)
    return if user_datetime.blank?
    if user_datetime < Date.today
      errors.add(:event_time, "は#{Date.tomorrow.strftime("%Y年%m月%d日")}以降で入力してください。")
    end
  end
  
end
