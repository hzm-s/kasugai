App.issueComments = App.cable.subscriptions.create "IssueCommentChannel",
  collection: -> $("[data-channel='issue-comments']")

  connected: ->
    setTimeout =>
      @start()
      @installPageChangeCallback()
    , 1000

  disconnected: ->
    # Called when the subscription has been terminated by the server

  start: ->
    console.log('start!!!')
    if issueId = @collection().data('issue-id')
      console.log('follow', issueId)
      @perform 'follow', issue_id: issueId
    else
      console.log('unfollow')
      @perform 'unfollow'

  received: (data) ->
    console.log('!!!', data['html'])

  installPageChangeCallback: ->
    $(document).on 'issue-comments-loaded turbolinks:load', -> App.issueComments.start()
