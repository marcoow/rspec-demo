# RSpec demo application

See <code>test</code>, <code>spec</code> and <code>features</code> directories for samples and comparison of **Test::Unit**, **RSpec** and **Cucumber**.

The application itself is pretty trivial and only has a <code>Task</code> model with a <code>title</code> and a <code>finished</code> flag. The controller allows to view, add and finish tasks. Deletion and editing of tasks is not implemented.

## Relevant rake tasks

### Test::Unit

**Run unit tests:**

    rake test:units

**Run functional tests:**

    rake test:functionals

**Run integration tests:**

    rake test:integration

**Run all of the above:**

    rake test

### RSpec

**Run model specs:**

    rake spec:models

**Run controller specs:**

    rake spec:controllers

**Run view specs:**

    rake spec:views

**Run all of the above:**

    rake spec

**Run code coverage analysis on specs:**

    rake spec:rcov

### Cucumber

**Run features:**

    rake features


## What you need

    sudo gem install rspec
    sudo gem install rspec-rails
    sudo gem install cucumber
    sudo gem install webrat
    sudo gem install rcov

## Author

Copyright (c) 2008 Marco Otte-Witte ([http://simplabs.com](http://simplabs.com)), released under the MIT license