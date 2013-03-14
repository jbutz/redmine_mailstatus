require 'redmine'

# Patches to the Redmine core.
RedmineApp::Application.config.after_initialize do
#  require_dependency 'issue'
#  # Guards against including the module multiple time (like in tests)
#  # and registering multiple callbacks
#  unless Issue.included_modules.include? RedmineMailstatus::IssuePatch
#    Issue.send(:include, RedmineMailstatus::IssuePatch)
#  end
#
  require_dependency 'projects_helper'
  unless ProjectsHelper.included_modules.include? RedmineMailstatus::ProjectsHelperPatch
    ProjectsHelper.send(:include, RedmineMailstatus::ProjectsHelperPatch)
  end
end

# It requires the file in lib/redmine_mailstatus/hooks.rb
require_dependency 'redmine_mailstatus/hooks/controller_issues_edit_before_save_hook'
require_dependency 'redmine_mailstatus/hooks/mailstatus_settings_tabs_hook'

Redmine::Plugin.register :redmine_mailstatus do
  name 'Redmine E-Mail Status Update Plugin'
  author 'Jason Butz'
  description 'If an e-mail is recived then the status can be updated.'
  version '0.0.1'
  author_url 'http://www.jasonbutz.info'
  url 'https://github.com/jbutz/redmine_mailstatus'
  
  # This plugin adds a project module
  # It can be enabled/disabled at project level (Project settings -> Modules)
  project_module :mailstatus do
    # These permissions has to be explicitly given
    # They will be listed on the permissions screen
    permission :edit_mailstatus, {:projects => :settings, :mailstatus => [:index, :edit]}, :require => :member
    permission :new_mailstatus, {:projects => :settings, :mailstatus => [:index, :new]}, :require => :member
    permission :view_mailstatus, {:projects => :settings, :mailstatus => :index}, :require => :member
  end
end
