# frozen_string_literal: true

class Client::Clients::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_from(:google)
  end

  private

  def callback_from(provider)
    provider = provider.to_s

    @client = Client.find_for_oauth(request.env['omniauth.auth'])

    if @client.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @client, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      sign_in_and_redirect root_url
    end
  end
end
