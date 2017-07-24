$(document).on 'click', '.edit-answer-link', (e) ->
  e.preventDefault()
  $(this).hide()
  answerId = $(this).data('answerId')
  $('form#edit_answer_' + answerId).show()