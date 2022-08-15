require 'rspec'
require 'active_support/inflector'
require_relative '../aa_questions'


describe User do 
    #reset database configuration 
    before(:each) { QuestionsDatabase.reset! }
    after(:each) { QuestionsDatabase.reset! }

    describe "::all" do 
        it "returns all the users" do 
            all_users = User.all 
            expect(all_users[0].fname).to eq("Jake")
            expect(all_users[0].lname).to eq("Shapiro")
            expect(all_users[1].fname).to eq("Ann")
            expect(all_users[1].lname).to eq("West")
            expect(all_users[2].fname).to eq("Mary")
            expect(all_users[2].lname).to eq("Madison")
        end 

        it "runs the query in the ModelBase class" do             
            expect(ModelBase).to receive(:all).with(User.to_s.tableize, User)
            User.all 
        end 

        it "hits the database 1 time" do  
            User.all 
            expect(QuestionsDatabase.database_hits).to eq(1)
        end 
    end 

    describe "::find_by_id" do 
        it "finds a user by id number" do 
            user = User.find_by_id(1)
            expect(user.fname).to eq("Jake")
            expect(user.lname).to eq("Shapiro")
        end 

        it "runs the query in the ModelBase class" do   
            expect(ModelBase).to receive(:find_by_id).with(User.to_s.tableize, 1, User)
            User.find_by_id(1)
        end 

        it "hits the database 1 time" do  
            User.find_by_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end 
    end 

    describe "::find_by_name" do 
        it "finds a user by first and last name" do 
            user = User.find_by_name("Jake", "Shapiro")
            expect(user.fname).to eq("Jake")
            expect(user.lname).to eq("Shapiro")
        end 

        it "hits the database 1 time" do  
            User.find_by_name("Jake", "Shapiro")
            expect(QuestionsDatabase.database_hits).to eq(1)
        end 
    end 

    describe "::where" do 
        it "returns a user based on a key-value pair" do 
            user = User.where({"id" => 1})
            user = user[0]
            expect(user.fname).to eq("Jake")
            expect(user.lname).to eq("Shapiro")
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:where).with(User.to_s.tableize, {"id" => 1}, User)
            User.where({"id" => 1})
        end 

        it "hits the database 1 time" do  
            User.where({"id" => 1})
            expect(QuestionsDatabase.database_hits).to eq(1)
        end 
    end 

    describe "#authored_questions" do
        it "returns a user's authored questions" do 
            user = User.find_by_id(1)
            user_authored_questions = user.authored_questions
            expect(user_authored_questions[0].author).to eq(1)
        end 

        it "runs the query in the Question class" do 
            expect(Question).to receive(:find_by_author_id).with(1)
            user = User.find_by_id(1)
            user.authored_questions
        end 

        it "hits the database 2 times" do  
            user = User.find_by_id(1)
            user.authored_questions
            expect(QuestionsDatabase.database_hits).to eq(2)
        end 
    end 

    describe "#authored_replies" do 
        it "returns the replies of a user" do 
            user = User.find_by_id(1)
            user_authored_replies = user.authored_replies
            expect(user_authored_replies[0].author_id).to eq(1)
            expect(user_authored_replies[1].author_id).to eq(1)
        end 

        it "runs the query in the Reply class" do 
            expect(Reply).to receive(:find_by_user_id).with(1)
            user = User.find_by_id(1)
            user.authored_replies
        end 

        it "hits the database 2 times" do  
            user = User.find_by_id(1)
            user.authored_replies
            expect(QuestionsDatabase.database_hits).to eq(2)
        end 
    end 

    describe "#followed_questions" do 
        it "returns the questions a user is following" do 
            user = User.find_by_id(1)
            user_followed_questions = user.followed_questions
            expect(user_followed_questions[0]["user_id"]).to eq(1)
            expect(user_followed_questions[1]["user_id"]).to eq(1)
            expect(user_followed_questions[2]["user_id"]).to eq(1)
        end 

        it "runs the query in the QuestionFollow class" do 
            expect(QuestionFollow).to receive(:followed_questions_for_user_id).with(1)
            user = User.find_by_id(1)
            user.followed_questions
        end 

        it "hits the database 2 times" do  
            user = User.find_by_id(1)
            user.followed_questions
            expect(QuestionsDatabase.database_hits).to eq(2)
        end
    end 

    describe "#liked_questions" do 
        it "returns the questions a user has liked" do 
            user = User.find_by_id(1)
            user_liked_questions = user.liked_questions
            expect(user_liked_questions[0]["question_id"]).to eq(1)
            expect(user_liked_questions[1]["question_id"]).to eq(2)
        end 

        it "runs the query in the QuestionLike class" do 
            expect(QuestionLike).to receive(:liked_questions_for_user_id).with(1)
            user = User.find_by_id(1)
            user.liked_questions
        end 

        it "hits the database 2 times" do  
            user = User.find_by_id(1)
            user.liked_questions
            expect(QuestionsDatabase.database_hits).to eq(2)
        end
    end 

    describe "#average_karma" do 
        it "calculates the average number of likes for a user's questions" do 
            user = User.find_by_id(1)
            user_average_karma = user.average_karma 
            expect(user_average_karma).to eq(1.0)
        end 

        it "hits the database 3 times" do  
            user = User.find_by_id(1)
            user.average_karma 
            expect(QuestionsDatabase.database_hits).to eq(3)
        end
    end 

    describe "#save" do 
        it "saves a user to the database" do 
            new_user = User.new({"fname" => "George", "lname" => "Roberts"})
            new_user.save 
            all_users = User.all
            expect(all_users.last.fname).to eq("George")
            expect(all_users.last.lname).to eq("Roberts")
        end 
    end 

    describe "#update" do 
        it "updates a user's information in the database" do 
            new_user = User.new({"fname" => "George", "lname" => "Roberts"})
            new_user.save 
            new_user.fname = "Carl"
            new_user.update 
            all_users = User.all 
            expect(all_users.last.fname).to eq("Carl")
            expect(all_users.last.lname).to eq("Roberts")
        end 
    end 
end 


describe Question do 
    #set doubles 
    let(:qf) { double(QuestionFollow) }

    #reset database configuration 
    before(:each) { QuestionsDatabase.reset! }
    after(:each) { QuestionsDatabase.reset! }

    describe "::all" do 
        it "returns all the questions" do 
            all_questions = Question.all 
            expect(all_questions[0].title).to eq("Jake Question")
            expect(all_questions[1].title).to eq("Ann Question")
            expect(all_questions[2].title).to eq("Mary Question")
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:all).with(Question.to_s.tableize, Question)
            Question.all 
        end 

        it "hits the database 1 time" do 
            Question.all 
            expect(QuestionsDatabase.database_hits).to eq(1)
        end 
    end 

    describe "::find_by_id" do 
        it "finds a question by the id" do 
            question = Question.find_by_id(1)
            expect(question.title).to eq("Jake Question")
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:find_by_id).with(Question.to_s.tableize, 1, Question)
            Question.find_by_id(1)
        end

        it "hits the database 1 time" do 
            Question.find_by_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end 
    end 

    describe "::find_by_author_id" do 
        it "finds a question by author id" do 
            question = Question.find_by_author_id(1)
            expect(question[0].title).to eq("Jake Question")
        end 

        it "hits the database 1 time" do 
            Question.find_by_author_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end 
    end 

    describe "::most_followed" do 
        it "returns the most followed question" do
            question = Question.most_followed(1)
            expect(question["question_id"]).to eq(3) 
        end 

        it "returns the least followed question" do
            question = Question.most_followed(3)
            expect(question["question_id"]).to eq(1) 
        end 

        it "runs the query in the QuestionFollow class" do 
            allow(qf).to receive(:most_followed_questions).with(1).and_return([
                {"question_id"=>3, "title"=>"Mary Question", "body"=>"Mary Mary Mary", "author"=>3, "follows"=>3}
            ])
            Question.most_followed(1) 
        end 

        it "hits the database 1 time" do 
            Question.most_followed(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end 
    end 

    describe "::most_liked" do 
        it "returns the most liked question" do 
            question = Question.most_liked(1)
            expect(question[0]["title"]).to eq("Ann Question")
        end 

        it "returns the 3 most liked questions" do 
            questions = Question.most_liked(3)
            expect(questions[0]["question_id"]).to eq(2)
            expect(questions[1]["question_id"]).to eq(3)
            expect(questions[2]["question_id"]).to eq(1)
        end 

        it "runs the query in the QuestionLike class" do
            expect(QuestionLike).to receive(:most_liked_questions).with(1)
            Question.most_liked(1)
        end 

        it "hits the database 1 time" do 
            Question.most_liked(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::where" do 
        it "returns a question based on a key-value pair" do 
            question = Question.where({"id" => 1})
            expect(question[0].title).to eq("Jake Question")
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:where).with(Question.to_s.tableize, {"id" => 1}, Question)
            Question.where({"id" => 1})
        end 

        it "hits the database 1 time" do 
            Question.where({"id" => 1})
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "#replies" do 
        it "returns the replies of a question" do 
            question = Question.find_by_id(1)
            replies = question.replies 
            expect(replies[0].body).to eq("Ann Reply to Jake Question")
            expect(replies[1].body).to eq("Mary Reply to Jake Question")
        end 

        it "runs the query in the Reply class" do 
            expect(Reply).to receive(:find_by_question_id).with(1)
            question = Question.find_by_id(1)
            question.replies 
        end 

        it "hits the database 2 times" do 
            question = Question.find_by_id(1)
            question.replies 
            expect(QuestionsDatabase.database_hits).to eq(2)
        end
    end 

    describe "#followers" do 
        it "returns the followers of a question" do 
            question = Question.find_by_id(2)
            question_followers = question.followers 
            expect(question_followers[0]["user_id"]).to eq(1)
            expect(question_followers[1]["user_id"]).to eq(2)
        end 

        it "runs the query in the QuestionFollow class" do 
            expect(QuestionFollow).to receive(:followers_for_question_id).with(1)
            question = Question.find_by_id(1)
            question.followers 
        end 

        it "hits the database 2 times" do 
            question = Question.find_by_id(1)
            question.followers  
            expect(QuestionsDatabase.database_hits).to eq(2)
        end
    end 

    describe "#likers" do 
        it "returns the users that like a question" do 
            question = Question.find_by_id(2)
            question_likers = question.likers 
            expect(question_likers[0]["user_id"]).to eq(1)
            expect(question_likers[1]["user_id"]).to eq(2)
        end 

        it "runs the query in the QuestionLike class" do 
            expect(QuestionLike).to receive(:likers_for_question_id).with(2)
            question = Question.find_by_id(2)
            question.likers 
        end 

        it "hits the database 2 times" do 
            question = Question.find_by_id(2)
            question.likers 
            expect(QuestionsDatabase.database_hits).to eq(2)
        end
    end 

    describe "#num_likes" do 
        it "returns the number of likes of a question" do 
            question = Question.find_by_id(2)
            likes = question.num_likes
            expect(likes[0]["num_likes"]).to eq(2)
        end 

        it "runs the query in the QuestionLike class" do 
            expect(QuestionLike).to receive(:num_likes_for_question_id).with(2)
            question = Question.find_by_id(2)
            question.num_likes
        end 

        it "hits the database 2 times" do 
            question = Question.find_by_id(2)
            question.num_likes
            expect(QuestionsDatabase.database_hits).to eq(2)
        end
    end 

    describe "#save" do 
        it "saves a question to the database" do 
            new_question = Question.new({"author" => 4, "body" => "George George George", "title" => "George Question"})
            new_question.save 
            questions = Question.all 
            expect(questions.last.title).to eq("George Question")
        end 
    end 

    describe "#update" do 
        it "updates a question's information in the database" do
            new_question = Question.new({"author" => 4, "body" => "George George George", "title" => "George Question"})
            new_question.save 
            new_question.title = "Carl Question" 
            new_question.update  
            questions = Question.all 
            expect(questions.last.title).to eq("Carl Question")
        end 
    end 
end 


describe QuestionFollow do 
    #reset database configuration 
    before(:each) { QuestionsDatabase.reset! }
    after(:each) { QuestionsDatabase.reset! }

    describe "::find_by_id" do 
        it "returns a followed question by id" do 
            question_follow = QuestionFollow.find_by_id(1)
            expect(question_follow.user_id).to eq(1)
            expect(question_follow.question_id).to eq(1)
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:find_by_id).with(QuestionFollow.to_s.tableize, 1, QuestionFollow)
            QuestionFollow.find_by_id(1)
        end 

        it "hits the database 1 time" do 
            QuestionFollow.find_by_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::followers_for_question_id" do 
        it "returns the followers of a question" do 
            question_followers = QuestionFollow.followers_for_question_id(2)
            expect(question_followers[0]["user_id"]).to eq(1)
            expect(question_followers[1]["user_id"]).to eq(2)
        end 

        it "hits the database 1 time" do 
            QuestionFollow.followers_for_question_id(2)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::followed_questions_for_user_id" do 
        it "returns the questions a user follows" do 
            user_followed_questions = QuestionFollow.followed_questions_for_user_id(1)
            expect(user_followed_questions[0]["title"]).to eq("Jake Question")
            expect(user_followed_questions[1]["title"]).to eq("Ann Question")
            expect(user_followed_questions[2]["title"]).to eq("Mary Question")
        end 

        it "hits the database 1 time" do 
            QuestionFollow.followed_questions_for_user_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::most_followed_questions" do 
        it "returns the n most followed questions" do 
            questions = QuestionFollow.most_followed_questions(2)
            expect(questions[0]["question_id"]).to eq(3)
            expect(questions[1]["question_id"]).to eq(2)
        end 

        it "hits the database 1 time" do 
            QuestionFollow.most_followed_questions(2)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 
end 


describe QuestionLike do 
    #reset database configuration 
    before(:each) { QuestionsDatabase.reset! }
    after(:each) { QuestionsDatabase.reset! }

    describe "::all" do 
        it "returns all the liked questions" do 
            liked_questions = QuestionLike.all 
            expect(liked_questions[0].user_id).to eq(1)
            expect(liked_questions[0].question_id).to eq(1)
            expect(liked_questions[1].user_id).to eq(1)
            expect(liked_questions[1].question_id).to eq(2)
            expect(liked_questions[2].user_id).to eq(2)
            expect(liked_questions[2].question_id).to eq(2)
            expect(liked_questions[3].user_id).to eq(3)
            expect(liked_questions[3].question_id).to eq(3)
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:all).with(QuestionLike.to_s.tableize, QuestionLike)
            QuestionLike.all 
        end
        
        it "hits the database 1 time" do 
            QuestionLike.all 
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::find_by_id" do 
        it "finds a liked question by id" do 
            question = QuestionLike.find_by_id(1)
            expect(question.user_id).to eq(1)
            expect(question.question_id).to eq(1)
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:find_by_id).with(QuestionLike.to_s.tableize, 1, QuestionLike)
            QuestionLike.find_by_id(1)
        end 

        it "hits the database 1 time" do 
            QuestionLike.find_by_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::likers_for_question_id" do 
        it "returns the users that like a question" do  
            users_that_like_question = QuestionLike.likers_for_question_id(2)
            expect(users_that_like_question[0]["user_id"]).to eq(1)
            expect(users_that_like_question[1]["user_id"]).to eq(2)
        end 

        it "hits the database 1 time" do 
            QuestionLike.likers_for_question_id(2)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::num_likes_for_question_id" do 
        it "returns the number of likes for a question" do 
            num_likes_of_question = QuestionLike.num_likes_for_question_id(2)
            expect(num_likes_of_question[0]["num_likes"]).to eq(2)
        end 

        it "hits the database 1 time" do 
            QuestionLike.num_likes_for_question_id(2)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::liked_questions_for_user_id" do 
        it "returns the questions a user likes" do 
            questions = QuestionLike.liked_questions_for_user_id(1)
            expect(questions[0]["title"]).to eq("Jake Question")
            expect(questions[1]["title"]).to eq("Ann Question")
        end 

        it "hits the database 1 time" do 
            QuestionLike.liked_questions_for_user_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::most_liked_questions" do
        it "returns the most liked n questions" do 
            questions = QuestionLike.most_liked_questions(1)
            expect(questions[0]["question_id"]).to eq(2)
        end 

        it "hits the database 1 time" do 
            QuestionLike.most_liked_questions(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 
end 


describe Reply do 
    #reset database configuration 
    before(:each) { QuestionsDatabase.reset! }
    after(:each) { QuestionsDatabase.reset! }

    describe "::all" do 
        it "returns all the replies" do 
            replies = Reply.all 
            expect(replies[0].body).to eq("Ann Reply to Jake Question")
            expect(replies[1].body).to eq("Mary Reply to Jake Question")
            expect(replies[2].body).to eq("Jake Reply to Ann Question")
            expect(replies[3].body).to eq("Ann Reply to Ann Question")
            expect(replies[4].body).to eq("Jake Reply to Mary Question")
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:all).with(Reply.to_s.tableize, Reply)
            Reply.all
        end 

        it "hits the database 1 time" do 
            Reply.all 
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::find_by_id" do 
        it "finds a reply by id" do 
            reply = Reply.find_by_id(1)
            expect(reply.body).to eq("Ann Reply to Jake Question")
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:find_by_id).with(Reply.to_s.tableize, 1, Reply)
            Reply.find_by_id(1)
        end 

        it "hits the database 1 time" do 
            Reply.find_by_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::find_by_user_id" do 
        it "returns the replies of a user" do 
            replies = Reply.find_by_user_id(1)
            expect(replies[0].body).to eq("Jake Reply to Ann Question")
            expect(replies[1].body).to eq("Jake Reply to Mary Question")
        end 

        it "hits the database 1 time" do 
            Reply.find_by_user_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::find_by_question_id" do 
        it "returns the replies of a question" do 
            replies = Reply.find_by_question_id(1)
            expect(replies[0].body).to eq("Ann Reply to Jake Question")
            expect(replies[1].body).to eq("Mary Reply to Jake Question")
        end 

        it "hits the database 1 time" do 
            Reply.find_by_user_id(1)
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "::find_by" do 
        it "returns replies based on an options hash" do 
            replies = Reply.find_by({"question_id" => 2})
            expect(replies[0].body).to eq("Jake Reply to Ann Question")
            expect(replies[1].body).to eq("Ann Reply to Ann Question")
        end 

        it "runs the query in the ModelBase class" do 
            expect(ModelBase).to receive(:where).with(Reply.to_s.tableize, {"question_id" => 2}, Reply)
            Reply.find_by({"question_id" => 2})
        end 

        it "hits the database 1 time" do 
            Reply.find_by({"question_id" => 2})
            expect(QuestionsDatabase.database_hits).to eq(1)
        end
    end 

    describe "#child_replies" do 
        it "returns the child replies of a reply" do 
            new_reply = Reply.new({"author_id" => 4, "body" => "George Reply to Jake Question", "parent_reply_id" => 1, "question_id" => 1})
            new_reply.save 
            reply = Reply.find_by_id(1)
            replies = reply.child_replies
            expect(replies[0].body).to eq("Mary Reply to Jake Question")
            expect(replies[1].body).to eq("George Reply to Jake Question")
        end 

        it "hits the database 4 times" do 
            new_reply = Reply.new({"author_id" => 4, "body" => "George Reply to Jake Question", "parent_reply_id" => 1, "question_id" => 1})
            new_reply.save 
            reply = Reply.find_by_id(1)
            reply.child_replies
            expect(QuestionsDatabase.database_hits).to eq(4)
        end
    end 

    describe "#save" do 
        it "saves a reply to the database" do 
            new_reply = Reply.new({"author_id" => 4, "body" => "George Reply to Jake Question", "parent_reply_id" => 1, "question_id" => 1})
            new_reply.save 
            replies = Reply.all 
            expect(replies.last.body).to eq("George Reply to Jake Question")
        end 
    end

    describe "#update" do 
        it "updates a reply in the database" do 
            new_reply = Reply.new({"author_id" => 4, "body" => "George Reply to Jake Question", "parent_reply_id" => 1, "question_id" => 1})
            new_reply.save 
            new_reply.body = "Carl Reply to Jake Question"
            new_reply.update 
            replies = Reply.all 
            expect(replies.last.body).to eq("Carl Reply to Jake Question")
        end 
    end 
end 