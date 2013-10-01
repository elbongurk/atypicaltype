class UsersController < ApplicationController
  before_filter :authorize

  def edit
  end

  def update
    current_user.update(update_params)
    redirect_to edit_user_url
  end

  private

  def update_params
    params.require(:user).permit(:send_process_email, :send_ship_email)
  end
end

