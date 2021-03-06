class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  protect_from_forgery with: :exception
  before_filter :prevent_caching

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end


  private

  def prevent_caching
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

end
