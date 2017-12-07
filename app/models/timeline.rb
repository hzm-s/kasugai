class Timeline < SimpleDelegator

  def self.for_user(user_id, page = 1)
    days = nil
    daily_list =
      ActivityList::Project.daily_list_for_user(user_id) do |all_days|
        days = all_days.page(page).per(3)
      end
    new(days, daily_list)
  end

  def initialize(days, daily_list)
    super(daily_list)
    @days = days
  end

  def pages
    @pages ||= @days.without_count
  end
end
