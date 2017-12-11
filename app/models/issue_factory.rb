module IssueFactory

  def self.create(project_member, params)
    Issue.new(
      id: SecureRandom.hex(8),
      author: project_member.user,
      title: params.title,
      content: params.content
    )
  end
end
