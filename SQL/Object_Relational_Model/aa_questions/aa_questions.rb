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

    def initialize(user)
        @id = user['id']
        @fname = user['fname']
        @lname = user['lname']
    end 
end 

class Question
    attr_accessor :author, :body, :id, :question, :title

    def self.find_by_id(id)
        question_data = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE id = #{id}") 
        Question.new(question_data[0])  
    end 

    def initialize(question)
        @id = question['id']
        @title = question['title']
        @body = question['body']
        @author = question['author']
    end 
end 

class QuestionFollow
    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
        question_follow_data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows WHERE id = #{id}") 
        QuestionFollow.new(question_follow_data[0])
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

    def initialize(reply)
        @id = reply['id'] 
        @question_id = reply['question_id']
        @parent_reply_id = reply['parent_reply_id']
        @author_id = reply['author_id']
        @body = reply['body']
    end 
end 