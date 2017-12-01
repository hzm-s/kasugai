module ActivityList
  class << self

    def group_by_date(all)
      all
        .group_by { |r| r.created_at.to_date }
        .map.with_index { |(date, subset), i| ActivityList::Daily.group_by_project(i, date, subset) }
    end
  end
end
