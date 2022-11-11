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
      self.columns.each do |column|
        define_method("#{column}=") { |value| attributes[column] = value } 
        define_method(column) { attributes[column] }  
      end 
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
    database_hash_objects = 
    DBConnection.execute(<<-SQL)
        SELECT 
          cats.*
        FROM 
          cats
      SQL

    self.parse_all(database_hash_objects)
  end

  def self.parse_all(results)
    results.map { |hash_object| self.new(hash_object) } 
  end

  def self.find(id)
    hash_object = 
    DBConnection.execute(<<-SQL)
        SELECT 
          cats.*
        FROM 
          cats
        WHERE 
          id = "#{id}"
      SQL
    self.parse_all(hash_object).first
  end

  def initialize(params = {})
    params.each do |column, value| 
      if self.class.columns.include?(column.to_sym)
        self.send("#{column.to_sym}=", value)
      else 
        raise "unknown attribute '#{column}'"
      end 
    end 
  end

  def attributes
    @attributes ||= {} 
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

  self.finalize! #create getter and setter methods for each column 
end





