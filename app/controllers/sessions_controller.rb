# frozen_string_literal: true

# Sessions Controller
class SessionsController < Devise::SessionsController
  before_action :store_location, only: %i[new]

  def new
    super
  end

  def store_location
    path = request.referer
    session[:previous_url] = path unless path =~ %r{/users}
  end
end
