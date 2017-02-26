App.cable.subscriptions.create "AppearanceChannel",
  connected: ->
    @appear()

  disconnected: ->
    @disappear()

  rejected: ->
    @uninstall()

  received: (data) ->
    $('ul#users').html(this.renderUsers(data.user_list));

  renderUsers: (data) ->
    users = []
    $.each data, (i, user) ->
      users.push('<li>'+user+'</li>')
    return users

  appear: ->
    @perform 'appear'

  disappear: ->
    @perform 'disappear'
