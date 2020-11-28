class ApplicationController < ActionController::Base
  before_action :authenticate_admin!

  protected

  def only_to_development
    head(:bad_request) unless Rails.env.development?
  end
end
