class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  class UsernameIsTaken < StandardError;end

  private

  def current_user
    user = session[:user]
    add_to_user_list(username: user['name']) if user
    user
  end

  def set_current_user(user)
    add_to_user_list(username: user['name'], set_user: true) if user
    session[:user] = user
    cookies[:username] = user.try(:fetch, 'name')
  end

  def add_to_user_list(username:, set_user: false)
    $user_list ||= [SimpleChat::Application::BOT_NAME]
    if $user_list.include?(username) && set_user
      raise UsernameIsTaken, 'Username has been taken'
    elsif !$user_list.include?(username)
      $user_list << username
    end
  end
end
  
