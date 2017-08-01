ready = ->
  $('.vote-link').on('ajax:success', (e, data, status, xhr) ->
    rating = '#rating_' + data.id
    notVoted = '#not_voted_' + data.id
    voted = '#voted_' + data.id
    $(rating).html data.content[0]
    if data.content[1] == true
      $(notVoted).hide()
      $(voted).show()
    else
      $(notVoted).show()
      $(voted).hide()
    return
  ).on 'ajax:error', (e, response, status, xhr) ->
    data = response.responseJSON
    rating = '#rating_' + data.id
    $(rating).html data.content

$(document).ready(ready)
$(document).on('turbolonks:load', ready);