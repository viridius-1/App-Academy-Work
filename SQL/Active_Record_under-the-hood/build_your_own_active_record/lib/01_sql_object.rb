require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @columns.nil? 
      cats_table_data =
      DBConnection.execute2(<<-SQL)
        SELECT 
          id, name, owner_id
        FROM 
          cats
        LIMIT 
          1
      SQL
      @columns = cats_table_data[0].map(&:to_sym)
    else 
      @columns 
    end 
  end

  def self.finalize!
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    if @table_name.nil?  
      self.table_name = self.to_s.tableize
    else 
      @table_name
    end    
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





