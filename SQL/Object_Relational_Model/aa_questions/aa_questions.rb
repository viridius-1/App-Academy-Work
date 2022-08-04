require 'sqlite3'
require 'singleton'
require 'byebug'

class QuestionsDatabase < SQLite3::Database 
    include Singleton

    def initialize 
        super('questions.db')
        self.type_translation = true 
        self.results_as_hash = true 
    end 
end 

class User
    attr_accessor :fname, :id, :lname

    def self.find_by_id(id)
        user_data = QuestionsDatabase.instance.execute("SELECT * FROM users WHERE id = #{id}") 
        User.new(user_data[0])
    end 

    def self.find_by_name(fname, lname)
        user_data = QuestionsDatabase.instance.execute("SELECT * FROM users WHERE fname = '#{fname}' AND lname = '#{lname}'") 
        User.new(user_data[0])
    end 

    def initialize(user)
        @id = user['id']
        @fname = user['fname']
        @lname = user['lname']
    end 

    def authored_questions 
        Question.find_by_author_id(id) 
    end 

    def authored_replies 
        Reply.find_by_user_id(id)
    end 

    def followed_questions 
        QuestionFollow.followed_questions_for_user_id(id)
    end 
end 

class Question
    attr_accessor :author, :body, :id, :question, :title

    def self.find_by_id(id)
        question_data = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE id = #{id}") 
        Question.new(question_data[0])  
    end 

    def self.find_by_author_id(author)
        question_data = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE author = #{author}")
        Question.new(question_data[0])  
    end 

    def initialize(question)
        @id = question['id']
        @title = question['title']
        @body = question['body']
        @author = question['author']
    end 

    def get_author 
        author
    end 

    def replies
        Reply.find_by_question_id(id)
    end 

    def followers 
        QuestionFollow.followers_for_question_id(id)
    end 
end 

class QuestionFollow
    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
        question_follow_data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows WHERE id = #{id}") 
        QuestionFollow.new(question_follow_data[0])
    end 

    def self.followers_for_question_id(question_id)
        question_follow_data = QuestionsDatabase.instance.execute("
            SELECT 
                user_id, fname, lname, question_id
            FROM 
                question_follows
            JOIN 
                users ON question_follows.user_id = users.id 
            WHERE 
                question_id = #{question_id}
        ") 
    end 

    def self.followed_questions_for_user_id(user_id)
        question_follow_data = QuestionsDatabase.instance.execute("
            SELECT 
                questions.id, title, body, author, user_id
            FROM 
                questions 
            JOIN 
                question_follows ON questions.id = question_id 
            WHERE 
                user_id = #{user_id} 
        ")
    end 

    def initialize(question_follow)
        @id = question_follow['id']
        @user_id = question_follow['user_id']
        @question_id = question_follow['question_id']
    end 
end 

class QuestionLike
    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
        question_like_data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes WHERE id = #{id}")
        QuestionLike.new(question_like_data[0])
    end 

    def initialize(question_like)
        @id = question_like['id']
        @user_id = question_like['user_id']
        @question_id = question_like['question_id']
    end 
end 

class Reply
    attr_accessor :author_id, :body, :id, :parent_reply_id, :question_id

    def self.find_by_id(id)
        reply_data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE id = #{id}")
        Reply.new(reply_data[0])
    end 

    def self.find_by_user_id(user_id)
        reply_data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE author_id = #{user_id}")
        reply_data.map { |datum| Reply.new(datum) }
    end 

    def self.find_by_question_id(question_id)
        reply_data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE question_id = #{question_id}")
        reply_data.map { |datum| Reply.new(datum) }
    end 

    def initialize(reply)
        @id = reply['id'] 
        @question_id = reply['question_id']
        @parent_reply_id = reply['parent_reply_id']
        @author_id = reply['author_id']
        @body = reply['body']
    end 

    def author 
        author_id
    end 

    def question 
        question_id 
    end 

    def parent_reply 
        parent_reply_id
    end 

    def child_replies 
        reply_data = QuestionsDatabase.instance.execute("
            SELECT 
                *
            FROM 
                replies 
            WHERE 
                parent_reply_id IS NOT NULL 
                AND 
                parent_reply_id = #{self.id} 
            LIMIT 
                1  
            ") 
        Reply.new(reply_data[0])  
    end 
end 
