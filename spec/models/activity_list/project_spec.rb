require 'rails_helper'

RSpec.describe ActivityList::Project, type: :model do
  describe '.daily_list_for_user' do
    it do
      user_a = sign_up
      user_b = sign_up

      project1 = create_project(user_a, name: 'P1')
      add_project_member(project1, user_b)
      project2 = create_project(user_a, name: 'P2')
      add_project_member(project2, user_b)

      project3 = create_project(user_b, name: 'P3')

      member1_a = user_a.as_member_of(project1)
      member1_b = user_b.as_member_of(project1)
      member2_a = user_a.as_member_of(project2)
      member2_b = user_b.as_member_of(project2)
      member3_b = user_b.as_member_of(project3)

      act_P1_0101_1, act_P2_0101_1, act_P1_0102_1, act_P1_0103_1, act_P2_0103_2 = nil
      Timecop.travel(Time.zone.parse('2017-01-01')) do
        create_issue(member1_a, title: 'P1_I1')
        act_P1_0101_1 = ProjectActivity.last

        create_issue(member2_b, title: 'P2_I1')
        act_P2_0101_1 = ProjectActivity.last

        create_issue(member3_b, title: 'P3_I1')
      end
      Timecop.travel(Time.zone.parse('2017-01-02')) do
        create_issue(member1_b, title: 'P1_I2')
        act_P1_0102_1 = ProjectActivity.last
      end
      Timecop.travel(Time.zone.parse('2017-01-03')) do
        create_issue(member1_a, title: 'P1_I3')
        act_P1_0103_1 = ProjectActivity.last

        create_issue(member2_a, title: 'P2_I1')
        act_P2_0103_2 = ProjectActivity.last
      end

      dailies = described_class.daily_list_for_user(user_a.id)
      aggregate_failures do
        expect(dailies.size).to eq(3)

        dailies[0].tap do |daily|
          expect(daily.date).to eq(Date.parse('2017-01-03'))
          expect(daily.project_list.size).to eq(2)

          daily.project_list[0].tap do |per_project|
            expect(per_project.project).to eq(project2)
            expect(per_project.activities).to eq([act_P2_0103_2])
          end

          daily.project_list[1].tap do |per_project|
            expect(per_project.project).to eq(project1)
            expect(per_project.activities).to eq([act_P1_0103_1])
          end
        end

        dailies[1].tap do |daily|
          expect(daily.date).to eq(Date.parse('2017-01-02'))
          expect(daily.project_list.size).to eq(1)

          daily.project_list[0].tap do |per_project|
            expect(per_project.project).to eq(project1)
            expect(per_project.activities).to eq([act_P1_0102_1])
          end
        end

        dailies[2].tap do |daily|
          expect(daily.date).to eq(Date.parse('2017-01-01'))
          expect(daily.project_list.size).to eq(2)

          daily.project_list[0].tap do |per_project|
            expect(per_project.project).to eq(project2)
            expect(per_project.activities).to eq([act_P2_0101_1])
          end

          daily.project_list[1].tap do |per_project|
            expect(per_project.project).to eq(project1)
            expect(per_project.activities).to eq([act_P1_0101_1])
          end
        end
      end
    end
  end
end
