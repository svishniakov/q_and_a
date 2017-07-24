ready = ->
  $('.vote-link').on('ajax:success', (e, data, status, xhr) ->
    rating = '#rating_' + data.id
    button = '#voting_' + data.id
    $(rating).html data.content
    $(button).load location.href + ' ' + button + '>*'
    return
  ).on 'ajax:error', (e, response, status, xhr) ->
    data = response.responseJSON
    $('.errors').html data.content

$(document).ready ready