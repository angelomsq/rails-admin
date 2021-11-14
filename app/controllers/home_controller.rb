class HomeController < ApplicationController
  # skip_before_action :authenticate_user!, :only => [:index]
  layout 'home'
  
  def index
    if not user_signed_in?
      redirect_to user_session_path
    else
      redirect_to admin_root_path
    end
  end
end
