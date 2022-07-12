# Behavioral

[![Build Status](https://github.com/saturnflyer/behavioral/actions/workflows/test.yml/badge.svg)](https://github.com/saturnflyer/behavioral/actions)
[![Code Climate](https://codeclimate.com/github/saturnflyer/behavioral.png)](https://codeclimate.com/github/saturnflyer/behavioral)
[![Gem Version](https://badge.fury.io/rb/behavioral.png)](http://badge.fury.io/rb/behavioral)

Add behavior to individual objects and remove it later _while preserving the existing behavior_.

This is _similar_ to [Casting](http://rubygems.org/gems/casting) in that it adds and removes behaviors and preserves `self` but it's different in that you can still use `super` inside your methods.

## Usage

Add Behavioral to your classes to add new features or override existing ones. Later you may remove your behaviors:

```ruby
class Person
  def initialize(name)
    @name = name
  end
  attr_reader :name
  
  include Behavioral
end

module Greeter
  def hello
    "Hello, I am #{self.name}"
  end
  
  def name
    "The Greeter #{super}"
  end
end

person = Person.new('Jim').with_behaviors(Greeter)
person.hello #=> "Hello, I am Jim"

person.without_behaviors(Greeter)
person.hello #=> NoMethodError
```

### This does not alter the ancestry

When you add behaviors, the methods are copied to the `singleton_class` of your object. Later, if you ask the object if it is of that type, the answer will be false.

```ruby
person = Person.new('Jim').with_behaviors(Greeter)
person.is_a?(Greeter) #=> false

#alternative
person = Person.new('Jim').extend(Greeter)
person.is_a?(Greeter) #=> true
```

## Installation

Add this line to your application's Gemfile:

    gem 'behavioral'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install behavioral

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
