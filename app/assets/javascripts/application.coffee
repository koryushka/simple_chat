#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree
#= require_tree ./channels

$ ->
  messages = $('#messages')
  height = messages[0].scrollHeight
  messages.scrollTop height
  return
