class StaticPagesController < ApplicationController
  def home
    @email = Email.new
  end

  def help
  end
  
  def about
  end
end
