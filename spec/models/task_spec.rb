require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Task do

  describe 'validation' do

    before do
      @task = Task.new(:title => 'test task')
    end

    it 'should succeed when all required attributres are set' do
      @task.should be_valid
    end

    it 'should not succeed when no title is set' do
      @task.title = nil

      @task.should_not be_valid
    end

    it 'should not succeed when a title with less than 5 characters is set' do
      @task.title = 'a' * 4

      @task.should_not be_valid
    end

    it 'should not succeed when a title with more than 5 characters is set' do
      @task.title = 'a' * 151

      @task.should_not be_valid
    end

  end

end
