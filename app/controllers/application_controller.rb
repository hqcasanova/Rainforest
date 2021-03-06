class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  #Fetches the current user if not done already 
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  #Fetches the current product.
  def load_product(id_symbol)
    @product = Product.find(params[id_symbol])
  end

  #Outputs date_time in format similar to Sat, 6 Sep 2014 23:10
  def formatted_datetime(date_time)
    date_time.strftime("%e %b %Y")
  end
  helper_method :formatted_datetime

  #Sanitized version of params
  def secure_params(require_param, permit_keys)
    params.require(require_param).permit(*permit_keys)
  end

  #TODO: Tries to guess the previous page based on the referrer and controller name
  #Still buggy
  def back_url
    if (controller_name == 'sessions') || (controller_name == 'users')
      url = controller_name + '/new'
    elsif (request.referrer != request.path)
      url = request.referrer
    elsif (controller_name != 'sessions') && (controller_name != 'users')
      url = root_path + controller_name
    else 
      url = root_path 
    end 
  end
  helper_method :back_url

  #Authorisation: Flashes an alert if the user is not logged in.
  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_path
    end
  end
end