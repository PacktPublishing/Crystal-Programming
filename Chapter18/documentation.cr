# This comment is not associated with MyClass.

# A summary of what MyClass does.
class MyClass; end

# This is the summary
# this is still the summary
#
# This is not the summary.
def foo; end

# This is the summary.
# This is no longer the summary.
def bar; end

# Creates and returns a default instance of `MyClass`.
def create : MyClass; end

# Returns of sum of *value1* and *value2*.
def add(value1 : Int32, value : Int32)
end

# ## Some Section
#
# I'm text in a sub headings.
#
# > A very special quote
#
# Todo list:
# * Item 1
# * Item 2
# * Item 3
#
# Task List:
#
# 1. Do thing 1
# 1. Do thing 2
#
# ```
# value = 2 + 2 => 4
# value # : Int32
# ```
#
# ```yaml
# ---
# id: 1
# user:
#   name: Fred
# ```
module MyModule; end

# Runs the application.
#
# DEPRECATED: Use `#execute` instead.
def run; end

# Returns the number of items within this collection.
def size; end

# :ditto:
def length; end

# :ditto:
#
# Some information specific to this method.
def count; end

# :nodoc:
#
# This is an internal method.
def internal_method; end

abstract class Vehicle
  # Returns the name of `self`.
  abstract def name
end

class Car < Vehicle
  def name
    "car"
  end
end

abstract class Parent
  # Some documentation common to every *id*.
  abstract def id : Int32
end

class Child < Parent
  # Some documentation specific to *id*'s usage within `Child`.
  #
  # :inherit:
  def id : Int32
    -1
  end
end
