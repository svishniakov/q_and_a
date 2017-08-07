$ ->
  answersList = $('div#answers')

  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      questionId = $('.card-header').data('id')
      @perform('follow', question_id: questionId)
    ,
    received: (data) ->
      answersList.append data
  })


$(document).on 'turbolinks:load', ->

$(document).on 'click', '.edit-answer-link', (e) ->
  e.preventDefault()
  $(this).hide()
  answerId = $(this).data('answerId')
  $('form#edit_answer_' + answerId).show()

$(document).on 'click', '.add-comment-link', (e) ->
  e.preventDefault()
  $(this).hide()
  answerId = $(this).data('answerId')
  $('form#answer_' + answerId + '_comments_form').show()
