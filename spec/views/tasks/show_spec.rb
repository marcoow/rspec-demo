require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe 'tasks/index' do

  before do
    @task = stub_model(Task, { :title => 'title' })
    assigns[:task] = @task
  end

  it "should render the task's title" do
    do_render

    response.should have_tag('h1', Regexp.compile(@task.title))
  end

  it 'should render a link to finish the task' do
    do_render

    response.should have_tag('a[href=?]', finish_task_path(@task))
  end

  it 'should render a link to tasks_path' do
    do_render

    response.should have_tag('a[href=?]', tasks_path)
  end

  def do_render
    render('tasks/show')
  end

end
