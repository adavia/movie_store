class ApplicationController < ActionController::Base
  include SessionsHelper
  #before_action :set_i18n_locale_from_params

  protect_from_forgery with: :exception

  before_action :authorize

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
