class BookmarkedIssue < ApplicationRecord
  class << self

    def add!(issue)
      create!(issue_id: issue.id)
    end

    def delete!(issue)
      find_by(issue_id: issue.id).destroy!
    end
  end
end
