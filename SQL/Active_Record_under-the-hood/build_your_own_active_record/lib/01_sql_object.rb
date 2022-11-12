require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns 
    if @columns.nil? && self != SQLObject
      table_data =
      DBConnection.execute2(<<-SQL)
        SELECT 
          *
        FROM 
          #{self.table_name}
        LIMIT 
          1
      SQL
      @columns = table_data[0].map(&:to_sym)
    else 
      @columns 
    end 
  end

  def self.finalize!
      if self != SQLObject
        self.columns.each do |column|
          define_method("#{column}=") { |value| attributes[column] = value } 
          define_method(column) { attributes[column] }  
        end 
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
          *
        FROM 
          #{self.table_name}
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
          *
        FROM 
          #{self.table_name}
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
    self.class.columns.map { |column| self.send(column) }
  end

  def insert
    col_names = self.class.columns[1..-1]
    col_names_string = col_names.join(', ')

    question_marks = (["?"] * col_names.length)
    question_marks_string = question_marks.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values[1..-1])
      INSERT INTO
        #{self.class.table_name} (#{col_names_string})
      VALUES
        (#{question_marks_string})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    #make SET line 
    set_line_arr = []
    columns = self.class.columns[1..-1]
    columns.each { |column| set_line_arr << "#{column} = ?" }  
    set_line_string = set_line_arr.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values[1..-1], self.id)
      UPDATE
        #{self.class.table_name} 
      SET
        #{set_line_string}
      WHERE
        id = ? 
    SQL
  end

  def save
    self.id.nil? ? self.insert : self.update 
  end

  self.finalize! #create getter and setter methods for each column 
end





