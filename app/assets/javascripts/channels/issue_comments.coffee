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
    @list().append(data.html) unless @userIsCurrentUser(data.html)

  userIsCurrentUser: (html) ->
    authorId = $(html).attr('data-author-id')
    currentUserId = $('meta[name=current-user]').attr('id').toString()
    authorId is currentUserId

  start: ->
    if issueId = @container().data('issue-id')
      @perform 'follow', issue_id: issueId
    else
      @perform 'unfollow'

  installPageChangeCallback: ->
    $(document).on 'turbolinks:load', -> App.issueComments.start()
