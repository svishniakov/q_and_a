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
  console.log("Show")
  $('form#edit_answer_' + answerId).show()