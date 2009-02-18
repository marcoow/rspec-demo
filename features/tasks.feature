Feature: Tasks
It should be able to manage tasks.

Scenario: List Tasks
Given that there is a task "task 1"
When I go to the tasks page
Then I should see "task 1"

Scenario: Finish Task
Given that there is a task "task 1"
When I finish task "task 1"
When I go to the tasks page
Then I should not see "task 1"

Scenario: Create Task
Given that there are no tasks
When I create task "task 1"
When I go to the tasks page
Then I should see "task 1"
