require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
  end

  def self.finalize!
  end

  def self.table_name=(table_name)
    @table_name = table_name

    # sets the table 
    #Since our SQLObject class is itself an object (an instance of Class, 
      #we can store that as a instance variable on the class #everythingisanobject.
  end

  def self.table_name
    if @table_name.nil?  
      self.table_name = self.to_s.tableize
    else 
      @table_name
    end    
    # gets the name of the table for the class
    #It would also be nice if, in the absence of an explicitly set table name, 
      #we would have ::table_name by default convert the class name to snake_case and pluralize:
      #ActiveSupport (part of Rails) has an inflector library that adds methods to String to help you do this.
      # In particular, look at the String#tableize method. You can require the inflector with require 'active_support/inflector'
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
