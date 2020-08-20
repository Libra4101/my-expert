class Client::ReservationConfirmationMailer < ApplicationMailer
  default from: "my-expert.work"

  # 相談予約完了メール
  def send_confirm_reservation(consultation)
    @consultation = consultation
    mail(
      to: @consultation.client.email,
      subject: 'MyExpert 予約確認',
      template_path: 'client'
    )
  end
end
