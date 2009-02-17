class TasksController < ApplicationController

  def index
    @tasks = Task.find(:all, :conditions => { :finished => false })
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    render :action => :new and return unless @task.save
    flash[:message] = 'Task created!'
    redirect_to tasks_url
  end

  def finish
    task = Task.find(params[:id])
    task.update_attribute(:finished, true)
    flash[:message] = 'Task finished!'
    redirect_to tasks_url
  end

end
