require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

describe 'tasks/new' do

  before do
    @task = stub_model(Task)
    @task.stub!(:new_record?).and_return(true)
    assigns[:task] = @task
  end

  it 'should render a form for the task' do
    do_render

    response.should have_tag('form[method="post"][action=?]', tasks_path) do
      with_tag('input#task_title[type="text"][name=?]', 'task[title]')
      with_tag('input[type="submit"]')
    end
  end

  it 'should render a link to tasks_path' do
    do_render

    response.should have_tag('a[href=?]', tasks_path)
  end

  def do_render
    render('tasks/new')
  end

end
