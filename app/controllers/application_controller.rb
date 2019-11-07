# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[firstname lastname \
                                                         email birthdate \
                                                         address password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[firstname \
                                                                lastname email \
                                                                birthdate \
                                                                address \
                                                                password])
  end
end
