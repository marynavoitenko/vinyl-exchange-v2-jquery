class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include CartsHelper

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || store_path
  end
end
