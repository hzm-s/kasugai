App.issue_comment = App.cable.subscriptions.create { channel: "IssueCommentChannel" },
  connected: ->
    setTimeout =>
      @followComments()
    , 1000

  disconnected: ->
    # Called when the subscription has been terminated by the server

  followComments: ->
    if issueId = $('#js-issue-detail').data('issue-id')
      @perform 'follow', issue_id: issueId
    else
      @perform 'unfollow'

  received: (data) ->
    console.log('!!!', data['html'])
