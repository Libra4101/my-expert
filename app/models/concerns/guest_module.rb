module GuestModule
  extend ActiveSupport::Concern

  module ClassMethods
    # ゲスト会員
    def guest_client
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

    # ゲスト専門家
    def guest_expert
      guest_job = Job.find_or_create_by!(title: "弁護士") do |job|
        job.content = "依頼を受けて法律事務を処理することを職務とする専門職"
      end

      guest_office = Office.find_or_create_by!(email: "guest-office@example.com") do |office|
        office.name = '法律事務所'
        office.email = 'guest-office@example.com'
        office.tel = '090-999-9999'
        office.postcode = '595-0022'
        office.address = '大阪府泉大津市池浦町'
        office.latitude = 34.498046
        office.longitude = 135.413332
        office.reception_start_time = Time.now
        office.reception_end_time = Time.now + 2
      end

      guest_expert = find_or_create_by!(email: 'guest-expert@example.com') do |expert|
        expert.password = SecureRandom.urlsafe_base64
        expert.name = '山下太郎'
        expert.name_kana = 'ヤマシタタロウ'
        expert.gender = 1
        expert.age = '56'
        expert.phone_number = '090-999-9999'
        expert.introduction = '自己紹介文'
        expert.public_status = false
        expert.job_id = guest_job.id
        expert.office_id = guest_office.id
      end

      return guest_expert
    end
  end
end