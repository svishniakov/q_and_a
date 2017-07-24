$(document).on 'turbolinks:load', ->

$(document).on 'click', '.edit-answer-link', (e) ->
  e.preventDefault()
  $(this).hide()
  answerId = $(this).data('answerId')
  console.log("Show")
  $('form#edit_answer_' + answerId).show()