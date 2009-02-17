require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  test 'TasksController should assign all tasks for the view' do
    get :index

    assert_not_nil assigns[:tasks]
  end



end
