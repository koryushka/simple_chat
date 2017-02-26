App.messages = App.cable.subscriptions.create('MessagesChannel',
  received: (data) ->
    $('#messages').removeClass 'hidden'
    $('#messages').append @renderMessage(data)
    $('#messages').animate { scrollTop: $('#messages').get(0).scrollHeight }, 2000
    return
  renderMessage: (data) ->
    $('#message_content').val ''
    username = $.cookie('username')
    current_class = if username == data.author then 'sent_message' else 'received_message'
    '<div class=' + '\'' + current_class + ' message\'>' +
    '<span class = \'message_icon\'> <img src = \'images/' +
     data.dialect + '.png\'>' + '</span>' + ' ' + data.created_at + ' ' + '<h2>' +
     '<b>' + data.author + ': ' + '</b>' + data.message + '</h2>'
)
