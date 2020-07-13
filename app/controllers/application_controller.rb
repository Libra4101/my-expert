class ApplicationController < ActionController::Base
  include DeviseHandlers

  private

  # # 新規登録後のパス設定（devise）
  # def after_sign_up_path_for(resource)
  #   case resource
  #   when Admin
  #     # 管理者用の新規登録画面なし
  #   when Client
  #     root_path
  #   end
  # end

  # # ログアウト後のパス設定（devise）
  # def after_sign_out_path_for(resource)
  #   case resource
  #   when :admin
  #     new_admin_session_path
  #   when :client
  #     root_path
  #   end
  # end
end
