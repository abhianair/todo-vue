class HomeController < ApplicationController
  before_action :authenticated?

  def index
    p current_user
  end


  def logout
    session['user'] = nil
    redirect_to getsso_host
  end

end
