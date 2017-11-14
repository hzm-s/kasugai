require 'rails_helper'

describe IssueCommentForm do
  let(:valid) do
    { content: 'Issue Comment Content' }
  end

  it do
    form = described_class.new(valid)
    expect(form).to be_valid
  end

  it do
    form = described_class.new(valid.merge(content: ''))
    expect(form).to_not be_valid
    expect(form.errors[:content]).to include('を入力してください')
  end

  it do
    form = described_class.new(valid.merge(content: 'a' * 10_001))
    expect(form).to_not be_valid
    expect(form.errors[:content]).to include('は10000文字以内で入力してください')
  end
end
