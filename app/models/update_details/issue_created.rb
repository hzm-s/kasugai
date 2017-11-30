module UpdateDetails
  class IssueCreated

    def initialize(issue:)
      @id = issue.id
      @title = issue.title
    end

    def description
      "課題を作成しました #{@title}"
    end
  end
end
