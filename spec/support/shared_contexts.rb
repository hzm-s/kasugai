shared_context '2人のユーザーがそれぞれプロジェクトを作成している' do
  let(:user_a) { sign_up }
  let(:user_b) { sign_up }
  let(:project_a) { create_project(user_a, name: 'The primary users project') }
  let(:project_b) { create_project(user_b, name: 'The other users project') }
end
