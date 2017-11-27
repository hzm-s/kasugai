App.issueComments = App.cable.subscriptions.create "IssueCommentsChannel",
  container: -> $("[data-channel='issue-comments']")
  list: -> $('#js-issue-comments')

  connected: ->
    setTimeout =>
      @start()
      @installPageChangeCallback()
    , 1000

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log('!!!', data.html)
    @list().append(data.html)

  start: ->
    console.log('start!!!')
    if issueId = @container().data('issue-id')
      console.log('follow', issueId)
      @perform 'follow', issue_id: issueId
    else
      console.log('unfollow')
      @perform 'unfollow'

  installPageChangeCallback: ->
    $(document).on 'turbolinks:load', -> App.issueComments.start()
