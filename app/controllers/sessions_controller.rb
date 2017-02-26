class SessionsController < ApplicationController
  before_action :set_dialects, only: [:create, :new]

  def new
  end

  def create
    set_current_user(session_params.to_h)
    if current_user
      redirect_to root_path
      flash[:success] = I18n.t('flash.welcome', username: current_user['name'])
    end
  rescue UsernameIsTaken
    flash[:danger] = I18n.t('flash.error')
    redirect_to root_path
  end

  def destroy
    $user_list.delete(current_user['name']) if $user_list
    set_current_user(nil)
    ActionCable.server.broadcast "appearance", user_list: $user_list
    redirect_to root_path
  end

  private

  def set_dialects
    names = Message.dialects.keys
    names.delete(SimpleChat::Application::BOT_NAME.downcase)
    @dialects = names.map{|e| e.to_s.upcase}
  end

  def session_params
    params.permit(:login_time, :name, :dialect)
  end
end
