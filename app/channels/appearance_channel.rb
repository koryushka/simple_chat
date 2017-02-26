class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    broadcast_bot_message welcome: true
    stream_from 'appearance'
  end

  def unsubscribed
    broadcast_bot_message
    $user_list.delete(current_user['name'])
    ActionCable.server.broadcast "appearance", user_list: $user_list
  end

  def appear
    add_to_user_list current_user['name']
    ActionCable.server.broadcast "appearance", user_list: $user_list
  end

  private

  def add_to_user_list username
    $user_list ||= [SimpleChat::Application::BOT_NAME]
    $user_list << username unless $user_list.include?(username)
  end

  def broadcast_bot_message welcome: false
    message = Message.create_bot_message(
      username: current_user['name'],
      welcome: welcome
    )
    ActionCable.server.broadcast 'messages',
        dialect: message.dialect,
        message: message.content,
        author: message.author,
        created_at: message.created_at
  end
end
