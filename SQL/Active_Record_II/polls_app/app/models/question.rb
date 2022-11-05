# == Schema Information
#
# Table name: questions
#   
#  id      :integer(8)      not null, primary key
#  text    :text            not null
#  poll_id :integer(4)      not null

class Question < ApplicationRecord 
    validates :text, presence: true 

    has_many :answer_choices,
        class_name: :AnswerChoice, 
        foreign_key: :question_id, #answer_choices table
        primary_key: :id, 
        dependent: :destroy 

    has_many :responses, 
        through: :answer_choices, 
        source: :responses

    belongs_to :poll, 
        class_name: :Poll, 
        foreign_key: :poll_id, #questions table 
        primary_key: :id 

    def results 
        #n + 1 code 
        # results_hash = {}
        # answer_choices.each { |answer_choice| results_hash[answer_choice.text] = Response.where(answer_choice_id: answer_choice.id).count } 
        # results_hash

        #fixing the n + 1 problem using includes 
        # results_hash = {} 
        # answers = answer_choices.includes(:responses)
        # answers.each { |answer_choice| results_hash[answer_choice.text] = answer_choice.responses.length }
        # results_hash

        #SQL query
        # SELECT 
        #     text, COUNT(responses) AS response_ct 
        # FROM 
        #     answer_choices 
        # LEFT OUTER JOIN 
        #     responses ON answer_choices.id = responses.answer_choice_id 
        # WHERE 
        #     answer_choices.question_id = 1 
        # GROUP BY 
        #     text, responses

        #ActiveRecord query 
        results_hash = {}
        answers = answer_choices.select(:text, 'COUNT(responses) AS response_ct').left_outer_joins(:responses).group('text, responses')
        answers.each { |answer_choice| results_hash[answer_choice.text] = answer_choice.response_ct }
        results_hash
    end 

    def delete
        self.destroy 
    end 
end 


