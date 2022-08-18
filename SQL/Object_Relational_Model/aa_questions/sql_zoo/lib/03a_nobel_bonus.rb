# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT DISTINCT 
      yr 
    FROM 
      nobels 
    WHERE 
      yr IN (
        SELECT DISTINCT 
          yr 
        FROM 
          nobels 
        GROUP BY 
          subject, yr 
        HAVING 
          subject = 'Physics'
        ) 
        AND 
        yr NOT IN(
          SELECT DISTINCT 
            yr 
          FROM 
            nobels
          GROUP BY 
            subject, yr
          HAVING 
            subject = 'Chemistry'
        )
  SQL
end
