# Acts as privilege

* * *

**This gem is outdated.  Please do not use it.**

* * *

Acts as privilege is a plugin for Ruby on Rails that provides the capabilities
to restrict controller actions to privileged resources.

This ACL-based security model is designed as a role-based access control, where
each role can be a group of users.

## Status

[![Gem Version](https://badge.fury.io/rb/acts_as_privilege.png)](http://badge.fury.io/rb/acts_as_privilege)
[![Build Status](https://api.travis-ci.org/cyril/acts_as_privilege.rb.png?branch=master)](http://travis-ci.org/cyril/acts_as_privilege?branch=master)
![](https://ruby-gem-downloads-badge.herokuapp.com/acts_as_privilege?type=total)

## Philosophy

General library that does only one thing, without any feature.

## Installation

Include the gem in your `Gemfile`:

    gem 'acts_as_privilege'

And run the `bundle` command.  Or as a plugin:

    rails plugin install git://github.com/cyril/acts_as_privilege.git

Then, generate files and apply the migration:

    rails generate privileges model
    rake db:migrate

At this point, `Privilege` model can be populated with:

``` ruby
rest_actions = %w(index show new create edit update destroy)
controllers = {
  groups:   rest_actions,
  users:    rest_actions,
  articles: rest_actions,
  comments: rest_actions }

Privilege.transaction do
  controllers.each_pair do |controller, actions|
    actions.each do |action|
      Privilege.create! route: [controller, action].join('#')
    end
  end
end
```

## Example

First, let's run commands:

    rails generate privileges group
    rake db:migrate

Second, let's add this in `Group` model:

``` ruby
# app/models/group.rb
class Group < ActiveRecord::Base
  acts_as_privilege

  has_many :users
end
```

Now, check the current user capability to destroy articles:

``` ruby
current_user.group.privilege?('articles#destroy') # => false
```

And add a form helper that generates the field to manage group privileges:

``` ruby
form_for @group do |f|
  privileges_field f
end
```

Copyright (c) 2009-2011 Cyril Wack, released under the MIT license
