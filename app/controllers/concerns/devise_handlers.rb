module DeviseHandlers
  extend ActiveSupport::Concern

  # Devise Initialize Class
  class Client::ParameterSanitizer < Devise::ParameterSanitizer
    def initialize(*)
      super
      params = [
        :name,
        :name_kana,
        :email,
        :gender,
        :age,
        :address,
        :postcode,
        :phone_number,
        :avater_image,
        :withdraw_status
      ]
      permit(:sign_up, keys: params)
      permit(:account_update, keys: params)
    end
  end

  class Expert::ParameterSanitizer < Devise::ParameterSanitizer
    def initialize(*)
      super
      params = [
        :name,
        :name_kana,
        :gender,
        :age,
        :phone_number,
        :avater_image,
        :introduction,
        :public_status,
        :withdraw_status,
        :office,
        :job
      ]
      permit(:sign_up, keys: params)
      permit(:account_update, keys: params)
    end
  end

  included do
    layout :layout_for_devise
    before_action :devise_parameter_sanitizer, if: :devise_controller?
  end

  protected

  #-- layout設定 --#
  def layout_for_devise
    if devise_controller?
      case resource_name
      when :admin then 'admin/admin'
      when :client then 'client/client'
      when :expert then 'expert/expert'
      end
    else
      'application'
    end
  end

  #-- ストロングパラメータ設定 --#
  def devise_parameter_sanitizer
    if resource_class == Client
      Client::ParameterSanitizer.new(Client, :client, params)
    elsif resource_class == Expert
      Expert::ParameterSanitizer.new(Expert, :expert, params)
    else
      super
    end
  end

  #-- ログイン後のパス設定 --#
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Client
      root_path
    when Expert
      expert_root_path
    end
  end

  # ログアウト後のパス設定（devise）
  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :client
      root_path
    when :expert
      expert_root_path
    end
  end
end