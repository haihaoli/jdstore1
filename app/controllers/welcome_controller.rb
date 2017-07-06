class WelcomeController < ApplicationController

  def index
    flash[:notice] = "喵呜～"
  end

end
