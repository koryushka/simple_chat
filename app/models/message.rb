class Message < ApplicationRecord
  enum dialect: {
    yoda: 1,
    valley: 2,
    binary: 3,
    haxor: 4,
    bot: 5
  }

  def self.create_bot_message(username:, welcome: true)
    action = welcome ? 'joined'.freeze : 'left'.freeze
    create!(content: "#{username} #{action} chat", author: I18n.t('bot'), dialect: 5)
  end
end
