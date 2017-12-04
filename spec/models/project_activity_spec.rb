require 'rails_helper'

RSpec.describe ProjectActivity, type: :model do
  describe '.dailies_for_user' do
    it do
      user = sign_up
      project1 = create_project(user, name: 'P1')
      project2 = create_project(user, name: 'P2')
      member1 = user.as_member_of(project1)
      member2 = user.as_member_of(project2)

      act_P1_0101_1, act_P2_0101_1, act_P1_0102_1, act_P1_0103_1, act_P2_0103_2 = nil
      Timecop.travel(Time.zone.parse('2017-01-01')) do
        create_issue(member1, title: 'P1_I1')
        act_P1_0101_1 = ProjectActivity.order(:id).last

        create_issue(member2, title: 'P2_I1')
        act_P2_0101_1 = ProjectActivity.order(:id).last
      end
      Timecop.travel(Time.zone.parse('2017-01-02')) do
        create_issue(member1, title: 'P1_I2')
        act_P1_0102_1 = ProjectActivity.order(:id).last
      end
      Timecop.travel(Time.zone.parse('2017-01-03')) do
        create_issue(member1, title: 'P1_I3')
        act_P1_0103_1 = ProjectActivity.order(:id).last

        create_issue(member2, title: 'P2_I1')
        act_P2_0103_2 = ProjectActivity.order(:id).last
      end

      dailies = described_class.dailies_for_user(user.id)

      expect(dailies).to eq(
        [
          ActivityList::Daily.new(
            0,
            Date.parse('2017-01-03'),
            [
              ActivityList::Project.new(0, project2, [act_P2_0103_2]),
              ActivityList::Project.new(0, project1, [act_P1_0103_1])
            ]
          ),
          ActivityList::Daily.new(
            1,
            Date.parse('2017-01-02'),
            [ActivityList::Project.new(1, project1, [act_P1_0102_1])]
          ),
          ActivityList::Daily.new(
            2,
            Date.parse('2017-01-01'),
            [
              ActivityList::Project.new(2, project2, [act_P2_0101_1]),
              ActivityList::Project.new(2, project1, [act_P1_0101_1])
            ]
          ),
        ]
      )
    end
  end
end
