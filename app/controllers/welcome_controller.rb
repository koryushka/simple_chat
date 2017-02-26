class WelcomeController < ApplicationController
  def index
    if current_user
      @messages = Message.where(["messages.created_at > ?", current_user['login_time']])
      @message = Message.new
      @user = current_user
    else
      redirect_to '/sessions/new'
    end
  end
end
