class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  before_action :authorize

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
