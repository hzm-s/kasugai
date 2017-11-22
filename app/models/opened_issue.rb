class OpenedIssue < ApplicationRecord
  include RankedModel

  ranks :priority_order, with_same: :project_id
end
