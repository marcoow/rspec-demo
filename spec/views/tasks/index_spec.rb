require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe 'tasks/index' do

  before do
    @task = stub_model(Task)
    assigns[:tasks] = [@task]
  end

  it 'should render a list of tasks' do
    do_render

    response.should have_tag('ul.tasks > li', 1)
  end

  it 'should render links to the tasks' do
    do_render

    response.should have_tag('ul.tasks > li > a[href=?]', task_path(@task))
  end

  it 'should render a link to tasks/new' do
    do_render

    response.should have_tag('a[href=?]', new_task_path)
  end

  def do_render
    render('tasks/index')
  end

end
