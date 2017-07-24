ready = ->
  $('.vote-link').bind('ajax:success', (e, data, status, xhr) ->
    rating = '#rating_' + data.id
#    button = '#voting_' + data.id
    $(rating).html data.content
#    $(button).load location.href + ' ' + button + '>*'
    return
  ).on 'ajax:error', (e, response, status, xhr) ->
    data = response.responseJSON
    rating = '#rating_' + data.id
    $(rating).html data.content

$(document).ready(ready)
$(document).on('turbolonks:load', ready);