class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :signed_in?, :signed_out?, :current_user

  protected

  def handle_unverified_request
    super
    sign_out
  end

  def authorize
    unless signed_in?
      deny_access
    end
  end

  def signed_in?
    current_user.present?
  end

  def signed_out?
    !signed_in?
  end

  def sign_out(flash_message=nil)
    session[:user_id] = nil
    
    if flash_message
      flash[:notice] = flash_message
    end

    redirect_to root_url
  end

  def sign_in(user)
    if user.present?
      session[:user_id] = user.id
    end
  end

  def current_user
    if @current_user.nil? && session[:user_id].present?
      @current_user = User.find(session[:user_id])
    end
    @current_user
  end

  def deny_access(flash_message=nil)
    store_location

    if flash_message
      flash[:notice] = flash_message
    end

    if signed_in?
      redirect_to photos_url
    else
      redirect_to root_url
    end
    
  end

  private 

  def store_location
    if request.get?
      session[:return_to] = request.fullpath
    end
  end

  def redirect_back_or(default)
    redirect_to(return_to || default)
    clear_return_to
  end
  
  def return_to
    session[:return_to] || params[:return_to]
  end

  def clear_return_to
    session[:return_to] = nil
  end
end
