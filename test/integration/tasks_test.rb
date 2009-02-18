require 'test_helper'

class TasksTest < ActionController::IntegrationTest

  test 'create task and finish it' do
    get new_task_path
    assert_response :success

    post_via_redirect tasks_path, :task => { :title => 'title' }
    assert_equal tasks_path, path
    assert_equal 'Task created!', flash[:notice]

    get task_path(Task.find(:last))
    assert_response :success

    put_via_redirect finish_task_path(Task.find(:last))
    assert_equal tasks_path, path
    assert_equal 'Task finished!', flash[:notice]
  end

  def teardown
    Task.destroy_all
  end

end