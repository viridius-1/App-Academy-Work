# == Schema Information
#
# Table name: users
#
#  id       :integer(8)      not null, primary key
#  username :string          not null

class User < ApplicationRecord 
    validates :username, uniqueness: true, presence: true 

    has_many :authored_polls, 
        class_name: :Poll,
        foreign_key: :user_id, #polls table 
        primary_key: :id

    has_many :responses, 
        class_name: :Response, 
        foreign_key: :user_id, #responses table  
        primary_key: :id 

    #SQL subquery to get the responses of a user per poll
    def left_join_sql 
        <<-SQL
            LEFT JOIN  
                (SELECT 
                    poll_id, COUNT(*) AS response_ct 
                FROM 
                    responses 
                JOIN 
                    questions ON responses.question_id = questions.id 
                WHERE 
                    user_id = #{self.id} 
                GROUP BY 
                    poll_id) AS response_data ON polls.id = response_data.poll_id 
        SQL
    end 

    #returns polls where the user has answered all of the questions in the poll
    def completed_polls 
        #all the below commented code are for reference. This completed_polls method only uses the final part which is the AR call.
=begin 
        #SQL that returns data where a user has answered all questions of a poll 
        SELECT 
            polls.id AS poll_id, title, COUNT(*) AS question_ct, response_data.poll_id AS response_poll_id, response_data.response_ct AS response_ct 
        FROM 
            polls 
        JOIN 
            questions ON polls.id = questions.poll_id 
        LEFT JOIN 
            (SELECT 
                poll_id, COUNT(*) AS response_ct 
            FROM 
                responses 
            JOIN 
                questions ON responses.question_id = questions.id 
            WHERE 
                user_id = 1 
            GROUP BY 
                poll_id) AS response_data ON polls.id = response_data.poll_id 
        GROUP BY 
            title, polls.id, response_data.poll_id, response_data.response_ct 
        HAVING 
            response_data.response_ct = COUNT(title)
=end 

        #find_by_sql AR call 
        # Poll.find_by_sql "SELECT polls.id AS poll_id, title, COUNT(*) AS question_ct, response_data.poll_id AS response_poll_id, response_data.response_ct AS response_ct FROM polls JOIN questions ON polls.id = questions.poll_id LEFT JOIN (SELECT poll_id, COUNT(*) AS response_ct FROM responses JOIN questions ON responses.question_id = questions.id WHERE user_id = 1 GROUP BY poll_id) AS response_data ON polls.id = response_data.poll_id GROUP BY title, polls.id, response_data.poll_id, response_data.response_ct HAVING response_data.response_ct = COUNT(title)"
    
        #AR subquery to get the responses of a user per poll 
        # response_ct_subquery = Response.select('questions.poll_id', 'COUNT(*) AS response_ct').joins(:question).where(user_id: self.id).group('questions.poll_id')
        
        Poll.joins(:questions).joins(left_join_sql).group(:title, 'polls.id', 'response_data.response_ct').having('response_data.response_ct = COUNT(title)')
    end 

    #returns the polls where a user hasn't answered every question of the poll
    def incomplete_polls 
        Poll.joins(:questions).joins(left_join_sql).group(:title, 'polls.id', 'response_data.response_ct').having('response_data.response_ct >= 1 AND response_data.response_ct < COUNT(title)')
    end 
end 