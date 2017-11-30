require 'action_service'

class ApplicationService < ActionService::Base

  def record_project_update!(update_class, project_member, params)
    project_id = project_member.project_id
    user_id = project_member.user_id
    detail = UpdateDetails.const_get(update_class).new(params)
    ProjectUpdate.create!(project_id: project_id, user_id: user_id, detail: detail)
  end

  protected

    attr_reader :update_recorder
end
