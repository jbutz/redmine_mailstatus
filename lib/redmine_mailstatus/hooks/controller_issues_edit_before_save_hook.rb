module RedmineMailstatus
	module Hooks
		class ControllerIssuesEditBeforeSaveHook < Redmine::Hook::ViewListener
			def logger
				Rails.logger
			end
			def controller_issues_edit_before_save(context={})
				@issue = context[:issue]
				@project = Project.find(@issue.project_id)

				return unless @project.module_enabled?('mailstatus')
				if context[:params] && context[:params][:issue]
					@mailstatus = Mailstatus.find(:all, :conditions => { :project_id => @issue.project } ).first

					if @issue.status_id == @mailstatus.begin_status
						@issue.status_id = @mailstatus.end_status
					end
				end

				return ''
			end
		end
	end
end