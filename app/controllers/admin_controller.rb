class AdminController < ApplicationController
  before_action :authorize_admin!

  def index
    @total_orders = Order.count
  end

  private

  def authorize_admin!
    unless current_user.is_admin?
      redirect_to root_path, notice: "You must be an admin to do that."
    end
  end
end
