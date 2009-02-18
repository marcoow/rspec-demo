require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test 'Task should be valid when all required attributes are set' do
    task = Task.new(:title => 'test task')

    assert_valid task
  end

  test 'Task should not be valid when no title is set' do
    task = Task.new

    assert !task.valid?
  end

  test 'Task should not be valid when a title with less than 5 characters is set' do
    task = Task.new(:title => '1' * 4)

    assert !task.valid?
  end

  test 'Task should not be valid when a title with more than 5 characters is set' do
    task = Task.new(:title => '1' * 151)

    assert !task.valid?
  end

  test 'Task#finish! should execute update_attributes!(:finished => true)' do
    task = Task.new
    task.expects(:update_attributes!).with(:finished => true).once

    task.finish!
  end

end
