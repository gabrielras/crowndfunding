class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery prepend: true, with: :exception
  before_action :detect_mobile

  private

  def detect_mobile
    request.variant = :mobile if request.user_agent =~ /Mobile|webOS|iPhone/
  end
end
