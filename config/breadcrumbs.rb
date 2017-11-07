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

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
