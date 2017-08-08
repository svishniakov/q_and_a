$ ->
  questionComments = $('.question-comments')

  App.cable.subscriptions.create('QuestionsCommentsChannel', {
    connected: ->
      @perform 'follow'
    ,
    received: (data) ->
      questionComments.append data
  })
