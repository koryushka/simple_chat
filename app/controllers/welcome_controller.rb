class WelcomeController < ApplicationController
  def index
    if current_user
      # byebugwhere('created_at > ?', current_user['login_time'])

      @messages = Message.where(["messages.created_at > ?", current_user['login_time']]).order(created_at: :asc)
      @message = Message.new
      @user = current_user
    else
      redirect_to '/sessions/new'
    end
  end
end
