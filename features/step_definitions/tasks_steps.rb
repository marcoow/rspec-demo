Given /^that there is a task "(.*)"$/ do |title|
  Task.create!(:title => title)
end

Given /^that there are no tasks$/ do
  Task.destroy_all
end

When /^I go to the tasks page$/ do
  get tasks_url
end

When /^I finish task "(.*)"$/ do |title|
  task = Task.find_by_title(title)
  task.finish!
end

When /^I create task "(.*)"$/ do |title|
  post tasks_url, :task => { :title => title }
end

Then /^I should see "(.*)"$/ do |title|
  response.body.should =~ /#{title}/m
end

Then /^I should not see "(.*)"$/ do |title|
  response.body.should_not =~ /#{title}/m
end
