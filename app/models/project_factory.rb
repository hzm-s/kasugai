module ProjectFactory

  def self.create(user, params)
    attrs = {
      id: SecureRandom.hex(8),
      name: params.name,
      description: params.description
    }

    Project.new(attrs) do |p|
      p.members.build(user_id: user.id)
    end
  end
end
