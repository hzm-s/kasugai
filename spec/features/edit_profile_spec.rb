require 'rails_helper'

describe 'プロフィールの編集' do
  xit do
    name = 'User Name'
    email = 'user@example.com'
    user = sign_up(name: name, email: email)
    sign_in(user)
  end
end
