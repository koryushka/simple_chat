class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    message.author = current_user['name']
    message.dialect = current_user['dialect'].downcase
    message = Translator.new(message: message).execute
    if message.save
      ActionCable.server.broadcast 'messages',
          dialect: message.dialect,
          message: message.content,
          author: message.author,
          created_at: message.created_at
    else
      redirect_to root_path
    end
  end

  private

  def message_params
    required_params = params.require(:message).permit(:content)
    required_params[:content].squish!
    required_params
  end
end
