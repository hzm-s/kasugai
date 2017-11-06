class ProjectService < ApplicationService

  def create(user, params)
    id = SecureRandom.hex(8)
    Project.new(id: id, name: params.name, description: params.description) do |p|
      p.members.build(user_id: user.id)
      p.save!
    end
  end
end
