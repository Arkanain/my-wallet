class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_user

  private

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.all { render nothing: true, status: :forbidden }
      format.html { render file: "#{Rails.root}/public/403.html", status: 403, layout: false }
    end
  end

  def set_user
    sign_in(:user, User.first) unless current_user
  end
end
