require 'rails_helper'

RSpec.describe ProjectActivity, type: :model do
  describe '.dailies_for_user' do
    it do
      user = sign_up
      project = create_project(user, name: 'P')
      member = user.as_member_of(project)

      Timecop.travel(Time.zone.parse('2017-01-01')) do
        create_issue(member, title: 'I1')
      end
      Timecop.travel(Time.zone.parse('2017-01-02')) do
        create_issue(member, title: 'I2')
      end
      Timecop.travel(Time.zone.parse('2017-01-03')) do
        create_issue(member, title: 'I3')
      end

      dailies = described_class.dailies_for_user(user.id)

      activities = ProjectActivity.all.order(:id)

      expect(dailies).to eq(
        [
          DailyActivities.new(Date.parse('2017-01-03'), [activities[2]]),
          DailyActivities.new(Date.parse('2017-01-02'), [activities[1]]),
          DailyActivities.new(Date.parse('2017-01-01'), [activities[0]]),
        ]
      )
    end
  end
end
