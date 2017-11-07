require 'rails_helper'

describe IssueForm do
  let(:valid) do
    {
      title: 'title',
      content: 'content'
    }
  end

  it do
    form = described_class.new(valid)
    expect(form).to be_valid
  end

  it do
    form = described_class.new(valid.merge(title: ''))
    expect(form).to_not be_valid
    expect(form.errors[:title]).to include('を入力してください')
  end

  it do
    form = described_class.new(valid.merge(title: 'a' * 51))
    expect(form).to_not be_valid
    expect(form.errors[:title]).to include('は50文字以内で入力してください')
  end

  it do
    form = described_class.new(valid.merge(content: 'a' * 10_001))
    expect(form).to_not be_valid
    expect(form.errors[:content]).to include('は10000文字以内で入力してください')
  end
end
