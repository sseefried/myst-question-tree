# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout 'application'

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  def help
      Helper.instance
    end

    class Helper
      include Singleton
      include ActionView::Helpers::UrlHelper
    end

end
