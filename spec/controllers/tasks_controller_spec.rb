require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe TasksController do

  describe 'handling GET /tasks' do

    before do
      @task = stub_model(Task)
      Task.stub!(:find).and_return(@task)
    end

    it_should_behave_like 'all non-redirecting actions'

    it "should render the 'tasks/index' template" do
      do_request

      response.should render_template('tasks/index')
    end

    it 'should load all unfinished tasks' do
      Task.should_receive(:find).once.with(:all, :conditions => { :finished => false })

      do_request
    end

    it 'should assign the tasks for the view' do
      do_request

      assigns[:tasks].should == @task
    end

    def do_request
      get :index
    end

  end

  describe 'handling GET /tasks/new' do

    it_should_behave_like 'all non-redirecting actions'

    it "should render the 'tasks/new' template" do
      do_request

      response.should render_template('tasks/new')
    end

    it 'should instantiate a new tasks' do
      Task.should_receive(:new).once

      do_request
    end

    it 'should assign the task for the view' do
      do_request

      assigns[:task].should be_instance_of(Task)
      assigns[:task].should be_new_record
    end

    def do_request
      get :new
    end

  end

  describe 'handling POST /tasks' do

    before do
      @task = stub_model(Task)
      @task.stub!(:save)
      Task.stub!(:new).and_return(@task)
    end

    it 'should instantiate a new tasks with the specified parameters' do
      Task.should_receive(:new).once.with('title' => 'title').and_return(@task)

      do_request
    end

    it 'should save the new task' do
      @task.should_receive(:save).once.and_return(true)

      do_request
    end

    describe 'when the task can be saved' do

      before do
        @task.stub!(:save).and_return(true)
      end

      it 'should recirect to tasks_url' do
        do_request

        response.should redirect_to(tasks_url)
      end

      it 'should set a flash notice' do
        do_request

        flash[:notice].should_not be_nil
      end

    end

    describe 'when the task can not be saved' do

      before do
        @task.stub!(:save).and_return(false)
      end

      it "should render the 'tasks/new' template" do
        do_request

        response.should render_template('tasks/new')
      end

      it 'should not set a flash notice' do
        do_request

        flash[:notice].should be_nil
      end

    end

    def do_request
      post :create, :task => { :title => 'title' }
    end

  end

  describe 'handling GET /tasks/:id' do

    before do
      @task = stub_model(Task)
      Task.stub!(:find).and_return(@task)
    end

    it_should_behave_like 'all non-redirecting actions'

    it "should render the 'tasks/show' template" do
      do_request

      response.should render_template('tasks/show')
    end

    it 'should load the task' do
      Task.should_receive(:find).once.with('1')

      do_request
    end

    it 'should assign the task for the view' do
      do_request

      assigns[:task].should == @task
    end

    def do_request
      get :show, :id => '1'
    end

  end

  describe 'handling PUT /tasks/:id/finish' do

    before do
      @task = stub_model(Task)
      @task.stub!(:finish!)
      Task.stub!(:find).and_return(@task)
    end

    it 'should load the task' do
      Task.should_receive(:find).once.with('1')

      do_request
    end

    it 'should finish the task' do
      @task.should_receive(:finish!).once

      do_request
    end

    it 'should recirect to tasks_url' do
      do_request

      response.should redirect_to(tasks_url)
    end

    it 'should set a flash notice' do
      do_request

      flash[:notice].should_not be_nil
    end

    def do_request
      put :finish, :id => '1'
    end

  end

  describe 'route generation' do

    it "should route { :controller => 'tasks', :action => 'index' } to /tasks" do
      route_for(:controller => 'tasks', :action => 'index').should == '/tasks'
    end

    it "should route { :controller => 'tasks', :action => 'new' } to /tasks/new" do
      route_for(:controller => 'tasks', :action => 'new').should == '/tasks/new'
    end

    it "should route { :controller => 'tasks', :action => 'create' } to { :path => '/tasks', :method => :post }" do
      route_for(:controller => 'tasks', :action => 'create').should == { :path => '/tasks', :method => :post }
    end

    it "should route { :controller => 'tasks', :action => 'show', :id => '1' } to /tasks/1" do
      route_for(:controller => 'tasks', :action => 'show', :id => '1').should == '/tasks/1'
    end

    it "should route { :controller => 'tasks', :action => 'finish', :id => '1' } to { :path => '/tasks/1/finish', :method => :put }" do
      route_for(:controller => 'tasks', :action => 'finish', :id => '1').should == { :path => '/tasks/1/finish', :method => :put }
    end

  end

  describe 'route recognition' do

    it "should route GET /tasks to { :controller => 'tasks', :action => 'index' }" do
      params_from(:get, '/tasks').should == { :controller => 'tasks', :action => 'index' }
    end

    it "should route GET /tasks/new to { :controller => 'tasks', :action => 'new' }" do
      params_from(:get, '/tasks/new').should == { :controller => 'tasks', :action => 'new' }
    end

    it "should route POST /tasks to { :controller => 'tasks', :action => 'create' }" do
      params_from(:post, '/tasks').should == { :controller => 'tasks', :action => 'create' }
    end

    it "should route GET /tasks/1 to { :controller => 'tasks', :action => 'show', :id => '1' }" do
      params_from(:get, '/tasks/1').should == { :controller => 'tasks', :action => 'show', :id => '1' }
    end

    it "should route PUT /tasks/1/finish to { :controller => 'tasks', :action => 'finish', :id => '1' }" do
      params_from(:put, '/tasks/1/finish').should == { :controller => 'tasks', :action => 'finish', :id => '1' }
    end

  end

  describe 'routing helpers' do

    before do
      get :index
    end

    it "should generate /tasks for tasks_path" do
      tasks_path.should == '/tasks'
    end

    it "should generate /tasks/new for new_task_path" do
      new_task_path.should == '/tasks/new'
    end

    it "should generate /tasks/1 for task_path(1)" do
      task_path(1).should == '/tasks/1'
    end

    it "should generate /tasks/1/finish for finish_task_path(1)" do
      finish_task_path(1).should == '/tasks/1/finish'
    end

  end

end
