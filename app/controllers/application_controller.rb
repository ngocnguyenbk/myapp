class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_admin!

  protected

  def only_to_development
    head(:bad_request) unless Rails.env.development?
  end

  def pundit_user
    current_admin
  end
end
