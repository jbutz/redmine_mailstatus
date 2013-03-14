module RedmineMailstatus
  module Hooks
    class MailstatusSettingsTabsHooks  < Redmine::Hook::ViewListener
      def mailstatus_settings_tabs(context = {})
        @project = context[:project]
        if @project.module_enabled?('mailstatus') and User.current.allowed_to?({:controller => :mailstatus, :action => :index}, context[:project])
          context[:tabs].push({ :name    => 'mailstatus',
                                :action  => :view_mailstatus,
                                :partial => 'projects/settings/mailstatus',
                                :label => :mailstatus_menuitem})
        end
      end 
    end
  end
end
