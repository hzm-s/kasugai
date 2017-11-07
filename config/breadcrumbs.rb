crumb :project_home do |project|
  link t('project_navs.home'), project_url(project)
end

crumb :project_issues do |project|
  link t('project_navs.issues'), project_issues_url(project)
  parent :project_home, project
end

crumb :new_issue do |project|
  link t('project_navs.new_issue'), new_project_issue_url(project)
  parent :project_issues, project
end

crumb :edit_issue do |project, issue|
  link t('project_navs.edit_issue'), edit_project_issue_url(project, issue)
  parent :project_issues, project
end
