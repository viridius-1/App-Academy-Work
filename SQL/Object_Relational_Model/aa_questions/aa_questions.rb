require 'sqlite3'
require 'singleton'
require 'active_support/inflector'
require 'byebug'

class QuestionsDatabase < SQLite3::Database 
    include Singleton

    def initialize 
        super('questions.db')
        self.type_translation = true 
        self.results_as_hash = true 
    end 
end 

class ModelBase 

    def self.all(table, class_origin)
        data = QuestionsDatabase.instance.execute("SELECT * FROM #{table}")
        data.map { |datum| class_origin.new(datum) }
    end 
    
    def self.find_by_id(table, id, class_origin)
        data = QuestionsDatabase.instance.execute(<<-SQL, id) 
            SELECT 
                *
            FROM
                #{table}
            WHERE 
                id = ?  
        SQL
        class_origin.new(data[0])
    end 

    def self.save(id, object)
        unless id 
            object.create
        else 
            object.update 
        end 
    end 

end 

class User
    attr_accessor :fname, :id, :lname

    def self.all 
        ModelBase.all(self.to_s.tableize, self) 
    end 

    def self.find_by_id(id)
         ModelBase.find_by_id(self.to_s.tableize, id, self)
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

    def save
        ModelBase.save(id, self) 
    end 

    def create
        raise "#{self} already in database" if id 
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname) 
        INSERT INTO 
            users (fname, lname)
        VALUES 
            (?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end 

    def update 
        raise "#{self} not in database" unless @id 
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE 
            users 
        SET 
            fname = ?, lname = ? 
        WHERE 
            id = ?
        SQL
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

    def liked_questions 
        QuestionLike.liked_questions_for_user_id(id)
    end 

    def average_karma 
        #get data of the number of questions per user 
        user_num_questions_data = QuestionsDatabase.instance.execute("
            SELECT 
                COUNT(DISTINCT question_id) AS num_questions 
            FROM 
                questions 
            JOIN 
                question_likes ON questions.id = question_likes.question_id 
            WHERE 
                author = #{id}
        ")

        #get data of the total number of likes for the user's questions 
        user_total_likes_data = QuestionsDatabase.instance.execute("
            SELECT 
                COUNT(id) AS likes 
            FROM 
                question_likes 
            WHERE 
                question_id IN (
                    SELECT 
                        id 
                    FROM 
                        questions 
                    WHERE 
                        author = #{id}
                )
        ")
        
        #extract data
        user_num_questions = user_num_questions_data[0]["num_questions"]
        user_total_likes = user_total_likes_data[0]["likes"]

        #make avg. calculation. convert 1 number to float to perform calculation 
        user_total_likes.to_f / user_num_questions
    end 
end 

class Question
    attr_accessor :author, :body, :id, :question, :title

    def self.all 
        ModelBase.all(self.to_s.tableize, self)
    end 

    def self.find_by_id(id)
        ModelBase.find_by_id(self.to_s.tableize, id, self)
    end 

    def self.find_by_author_id(author)
        question_data = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE author = #{author}")
        Question.new(question_data[0])  
    end 

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)[n - 1]
    end 

    def self.most_liked(n)
        QuestionLike.most_liked_questions(n)
    end 

    def initialize(question)
        @id = question['id']
        @title = question['title']
        @body = question['body']
        @author = question['author']
    end 

    def save 
        ModelBase.save(id, self) 
    end 

    def create 
        raise "#{self} already in database" if @id 
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author)
        INSERT INTO 
            questions (title, body, author)
        VALUES
            (?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end 

    def update 
        raise "#{self} not in database" unless @id 
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author, @id)
        UPDATE 
            questions 
        SET 
            title = ?, body = ?, author = ?
        WHERE 
            id = ? 
        SQL
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

    def likers 
        QuestionLike.likers_for_question_id(id)
    end 

    def num_likes 
        QuestionLike.num_likes_for_question_id(id)
    end 
end 

class QuestionFollow
    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
         ModelBase.find_by_id(self.to_s.tableize, id, self)
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

    def self.most_followed_questions(n)
        question_follow_data = QuestionsDatabase.instance.execute("
            SELECT 
                question_id, title, body, author, COUNT(question_id) AS follows 
            FROM 
                question_follows 
            JOIN
                questions ON question_follows.question_id = questions.id 
            GROUP BY 
                question_id 
            ORDER BY 
                follows DESC 
            LIMIT 
                #{n} 
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

    def self.all 
        ModelBase.all(self.to_s.tableize, self)
    end 

    def self.find_by_id(id)
        ModelBase.find_by_id(self.to_s.tableize, id, self)
    end 

    def self.likers_for_question_id(question_id)
        question_like_data = QuestionsDatabase.instance.execute("
            SELECT 
                *
            FROM 
                users
            JOIN
                question_likes ON users.id = question_likes.user_id 
            WHERE 
                question_id = #{question_id}
        ")
    end 

    def self.num_likes_for_question_id(question_id)
        question_like_data = QuestionsDatabase.instance.execute("
            SELECT 
                COUNT(user_id)
            FROM 
                users
            JOIN
                question_likes ON users.id = question_likes.user_id 
            WHERE 
                question_id = #{question_id}
        ")
    end 

    def self.liked_questions_for_user_id(user_id)
        question_like_data = QuestionsDatabase.instance.execute("
            SELECT 
                questions.id, title, body, author, question_id
            FROM 
                questions
            JOIN 
                question_likes ON questions.id = question_likes.question_id
            WHERE 
                user_id = #{user_id}
        ")
    end 

    def self.most_liked_questions(n)
        question_like_data = QuestionsDatabase.instance.execute("
            SELECT 
                *, COUNT(question_id) AS likes 
            FROM 
                question_likes 
            JOIN 
                questions ON question_likes.question_id = questions.id 
            GROUP BY 
                question_id 
            ORDER BY 
                likes DESC 
            LIMIT 
                #{n}
        ")
    end 

    def initialize(question_like)
        @id = question_like['id']
        @user_id = question_like['user_id']
        @question_id = question_like['question_id']
    end 

    def create 
        raise "#{self} already in database" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
        INSERT INTO 
            question_likes (user_id, question_id)
        VALUES 
            (?, ?)     
        SQL
        id = QuestionsDatabase.instance.last_insert_row_id
    end 
end 

class Reply
    attr_accessor :author_id, :body, :id, :parent_reply_id, :question_id

    def self.all 
        ModelBase.all(self.to_s.tableize, self)
    end 

    def self.find_by_id(id)
         ModelBase.find_by_id(self.to_s.tableize, id, self)
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

    def save 
        ModelBase.save(id, self) 
    end 

    def create
        raise "#{self} already in database" if id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @author_id, @body)
        INSERT INTO
            replies (question_id, parent_reply_id, author_id, body)
        VALUES 
            (?, ?, ?, ?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end 

    def update 
        raise "#{self} not in database" unless id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @author_id, @body, @id)
        UPDATE
            replies 
        SET
            question_id = ?, parent_reply_id = ?, author_id = ?, body = ? 
        WHERE
            id = ?
        SQL
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



