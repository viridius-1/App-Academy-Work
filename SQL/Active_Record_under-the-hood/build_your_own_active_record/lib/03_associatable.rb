require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = options.has_key?(:primary_key) ? options[:primary_key] : :id 
    @foreign_key = options.has_key?(:foreign_key) ? options[:foreign_key] : "#{name}Id".underscore.to_sym
    @class_name = options.has_key?(:class_name) ? options[:class_name] : name.camelize
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options.has_key?(:primary_key) ? options[:primary_key] : :id 
    @foreign_key = options.has_key?(:foreign_key) ? options[:foreign_key] : "#{self_class_name}Id".underscore.to_sym
    @class_name = options.has_key?(:class_name) ? options[:class_name] : name.singularize.capitalize
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name.to_s, options) 
    define_method(name) do
      foreign_key = options.send(:foreign_key)
      class_name = options.model_class
      record = class_name.where(id: self.send(foreign_key))
      record[0]
    end 
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, self, options)
    define_method(name) do 
      foreign_key = options.send(:foreign_key)
      class_name = options.model_class
      records = class_name.where(foreign_key => self.send(:id))
    end 
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end


