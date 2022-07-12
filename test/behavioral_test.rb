require 'test_helper'

describe Behavioral do
  it 'gains behaviors and overrides existing methods' do
    person = Person.new('Jim')
    person.with_behaviors(Greeter)
    assert_equal "Hello, I am The Greeter Jim", person.hello
  end

  it 'removes behaviors leaving the previously-existing methods intact' do
    person = Person.new('Jim')
    person.with_behaviors(Greeter)
    assert_equal "The Greeter Jim", person.name
    person.without_behaviors(Greeter)
    error = assert_raises NoMethodError do
      person.hello
    end
    assert_match "undefined method `hello'", error.message
  end

  it 'reverts added behaviors' do
    person = Person.new('Jim')
    person.with_behaviors(Greeter)
    assert_equal "The Greeter Jim", person.name
    person.without_behaviors(Greeter)
    assert_equal "Jim", person.name
  end
  
  it 'allows adding multiple behavior modules at once' do
    person = Person.new('Jim')
    person.with_behaviors(Greeter, Admin)
    assert_equal "Hello, I am The Greeter Jim", person.hello
    assert person.admin?
  end
  
  it 'overwrites singleton methods from subsequent behaviors' do
    person = Person.new('Jim')
    person.with_behaviors(Greeter, OtherGreeter)
    assert_equal "Hi. Call me The Greeter Jim", person.hello
  end

  it 'ignores unknown methods when removing behaviors' do
    person = Person.new('Jim')
    person.without_behaviors(Greeter)
    err = assert_raises NoMethodError do
      person.hello
    end
    assert_match "undefined method `hello'", err.message
  end

  it 'handles super with arguments' do
    person = Person.new('Jim')
    person.with_behaviors(Greeter)
    assert_equal "method_with_argument + it works", person.method_with_argument("it works")
  end
end


class Person
  def initialize(name)
    @name = name
  end
  attr_reader :name
  include Behavioral

  def method_with_argument(arg)
    arg
  end
end

module Greeter
  def hello
    "Hello, I am #{self.name}"
  end

  def name
    "The Greeter #{super}"
  end

  def method_with_argument(arg)
    "method_with_argument + #{super}"
  end
end

module Admin
  def admin?
    true
  end
end

module OtherGreeter
  def hello
    "Hi. Call me #{self.name}"
  end
end
