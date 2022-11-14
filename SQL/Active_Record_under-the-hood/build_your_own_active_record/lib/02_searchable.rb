require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    #make where line 
    where_line_arr = []
    keys = params.keys 
    keys.each { |key| where_line_arr << "#{key} = ?" }
    where_line_string = where_line_arr.join(' AND ')

    hash_objects = 
    DBConnection.execute(<<-SQL, *params.values)
        SELECT 
          *
        FROM 
          #{self.table_name}
        WHERE 
          #{where_line_string}
      SQL
    self.parse_all(hash_objects)
end
end

class SQLObject
  extend Searchable
end
