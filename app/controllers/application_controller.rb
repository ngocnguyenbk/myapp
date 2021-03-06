class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_locale, :authenticate_admin!

  protected

  def only_to_development
    head(:bad_request) unless Rails.env.development?
  end

  def pundit_user
    current_admin
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end
end
