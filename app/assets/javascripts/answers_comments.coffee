$ ->
  answerComments = $('.answer-comments')

  App.cable.subscriptions.create('AnswersCommentsChannel', {
    connected: ->
      subscriptions = this
      answerComments.each ->
        subscriptions.perform 'follow',
          commentable_id: $(this).attr('id')
    ,
    received: (data) ->
      json = $.parseJSON(data)
      comment = json.comment
      commentable = json.commentable
      $("#" + commentable.id + " .answer-comments").append('<li>' + comment.body + '</li>')
  })
