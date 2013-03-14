RedmineApp::Application.routes.draw do
	match 'projects/:project_id/mailstatus/:action', :to => 'mailstatus'
	match 'projects/:project_id/mailstatus/:action/:id', :to => 'mailstatus'
end
