require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application

    config.load_defaults 5.2

    # タイムゾーン設定
    config.time_zone = "Tokyo"
    # 多言語対応ファイルのルート設定
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    # 日本語化
    config.i18n.default_locale = :ja
    # ジェネレーター設定
    config.generators do |g|
      g.assets false
      g.skip_routes false
      g.test_framework :rspec,    # RSpecを使用
        controller_specs: false,  # controller specは作らない
        view_specs: false,        # view specは作らない
        helper_specs: false,      # helper specは作らない
        routing_specs: false      # routing specは作らない
    end
    # エラーメッセージフィールド自動設定OFF
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
