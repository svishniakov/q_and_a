$ ->
  questionsList = $('.questions-list')

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      @perform 'follow'
    ,
    received: (data) ->
      questionsList.append data
  })

$(document).on 'click', '.add-comment-link', (e) ->
  e.preventDefault()
  $(this).hide()
  questionId = $(this).data('questionId')
  $('form#question_' + questionId + '_comments_form').show()
