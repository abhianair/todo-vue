require 'httparty'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticated?
    p session['user']
    if session.nil? || session['user'].nil?
      if params[:token].nil?
        return redirect_to "#{getsso_host}?redirect_url=#{request.original_url}"
      else
        verify_url = "#{getsso_host}/sso/verify_token?token=#{params[:token]}"
        p 'redirect_url'
        p verify_url
        response = HTTParty.get(verify_url)
        if response['success'] == true
          session['user'] = response['email']
        else
          return redirect_to "#{getsso_host}?redirect_url=#{request.original_url}"
        end
      end
    end
  end

  def user_signed_in?
    !session['user'].nil?
  end

  def current_user
    User.find_by_email(session['user'])
  end

  def getsso_host
    if Rails.env == "production"
      return "https://team.zennode.com"
    else
      return "http://lvh.me:4000"
    end
  end

  helper_method :user_signed_in?, :current_user

end
