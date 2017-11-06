require 'rails_helper'

describe User do
  describe '#initials=' do
    it do
      user = described_class.new
      user.initials = 'user@example.com'
      expect(user.initials).to eq('US')
    end
  end
end
