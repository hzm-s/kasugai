App.issueComments = App.cable.subscriptions.create("IssueCommentsChannel", {
  container: function() {
    return $("[data-channel='issue-comments']")
  },

  list: function() {
    return $('#js-issue-comments')
  },

  connected: function() {
    setTimeout(function() {
      App.issueComments.start();
      App.issueComments.installPageChangeCallback();
    }, 1000);
  },

  disconnected: function() {},

  received: function(data) {
    Helpers.appendNode(this.list(), $(data.html));
  },

  start: function() {
    var issueId = this.container().data('issue-id');
    if (issueId) {
      this.perform('follow', { issue_id: issueId });
    } else {
      this.perform('unfollow');
    };
  },

  installPageChangeCallback: function() {
    $(document).on('turbolinks:load', function() {
      App.issueComments.start();
    });
    $(window).on('beforeunload', function() {
      App.issueComments.perform('unfollow');
    })
  },
});
