# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[firstname lastname \
                                                         birthdate \
                                                         address \
                                                         image])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[firstname \
                                                                lastname \
                                                                birthdate \
                                                                address \
                                                                image])
  end

  def after_sign_in_path_for(_)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(_)
    request.referer || root_path
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end
end
