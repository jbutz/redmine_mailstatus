class MailstatusController < ApplicationController
  unloadable
  before_filter :find_project, :authorize, :only => [:index, :new, :edit]
  def index
    @issue_statuses = IssueStatus.all(:order => 'position')
    render('projects/settings/_mailstatus')
  end
  
  def new
    if @project == nil
      render_404
      return
    end
    @mailstatus     = Mailstatus.new(:project_id => @project.id )
    @issue_statuses = IssueStatus.all(:order => 'position')
    if request.post?
      #@mailstatus.project_id = params[:mailstatus][:project_id]
      @mailstatus.begin_status = params[:mailstatus][:begin_status]
      @mailstatus.end_status   = params[:mailstatus][:end_status]
      if @mailstatus.save
        flash[:notice] = l(:mailstatus_creation_success)
      else
        flash.now[:error] = l(:mailstatus_creation_failed)
      end
      redirect_to :controller => "projects", :action => 'settings', :id => @project.identifier, :tab => 'mailstatus'
    end
  end

  def edit
    @mailstatus = Mailstatus.find(params[:id])
    @issue_statuses = IssueStatus.all(:order => 'position')
    if request.post?
      if params[:delete]
        if @mailstatus.destroy
          flash[:notice] = l(:mailstatus_deletion_success)
        else
          flash.now[:error] = l(:mailstatus_deletion_failed)
        end
      elsif params[:save]
        if @mailstatus.update_attributes(params[:mailstatus])
          flash[:notice] = l(:mailstatus_save_success) 
        else
          flash.now[:error] = l(:mailstatus_save_failed)
        end
      end
      redirect_to :controller => "projects", :action => 'settings', :id => @project.identifier, :tab => 'mailstatus'
    end
  end


  private

  def find_project
    begin
      @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      render_404
      @project = nil
    rescue => e
      flash.now[:error] = e
      @project = nil
    end
  end
end
