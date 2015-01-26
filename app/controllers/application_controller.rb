class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  #helper_method eventbrite
  
  #def eventbrite
  #      @eb_client = EventbriteClient.new({ access_token: 'GZW7DOQMUBNPMNJRTR54'})
  #end
end
