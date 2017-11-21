crumb :project_home do |project|
  link t('project_navs.home'), project_url(project)
end

crumb :project_issues do |project|
  link t('projects.show.navs.issue_list'), project_issues_url(project)
  parent :project_home, project
end

crumb :project_members do |project|
  link t('projects.show.navs.manage_members'), project_members_url(project)
  parent :project_home, project
end

crumb :project_setting do |project|
  link t('projects.show.navs.setting'), edit_project_url(project)
  parent :project_home, project
end

crumb :show_issue do |project, issue|
  link t('project_navs.show_issue'), project_issue_url(project, issue)
  parent :project_issues, project
end

crumb :new_issue do |project|
  link t('project_navs.new_issue'), new_project_issue_url(project)
  parent :project_issues, project
end

crumb :edit_issue do |project, issue|
  link t('project_navs.edit_issue'), edit_project_issue_url(project, issue)
  parent :project_issues, project
end

crumb :project_closed_issues do |project|
  link t('project_navs.closed_issue_list'), project_closed_issues_url(project)
  parent :project_issues, project
end

crumb :show_closed_issue do |project|
  link t('project_navs.show_issue'), project_closed_issues_url(project)
  parent :project_closed_issues, project
end
