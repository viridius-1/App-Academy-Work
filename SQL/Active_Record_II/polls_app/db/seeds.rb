# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
user1 = User.create!(username: "Jake")
user2 = User.create!(username: "Mike")
user3 = User.create!(username: "Ann")

Poll.destroy_all
poll1 = Poll.create!(title: "Politics - Jake's Poll", user_id: user1.id)
poll2 = Poll.create!(title: "Countries - Mike's Poll", user_id: user2.id)
poll3 = Poll.create!(title: "Food - Ann's Poll", user_id: user3.id)

Question.destroy_all
question1 = Question.create!(text: "Who should be the next President?", poll_id: poll1.id)
question2 = Question.create!(text: "What political party do you belong to?", poll_id: poll1.id)
question3 = Question.create!(text: "In the future, what will be the most powerful country in the world?", poll_id: poll2.id)
question4 = Question.create!(text: "What country would you most like to visit?", poll_id: poll2.id)
question5 = Question.create!(text: "What is your favorite food?", poll_id: poll3.id)
question6 = Question.create!(text: "What is your favorite drink?", poll_id: poll3.id)
question7 = Question.create!(text: "What is your favorite kind of yogurt?", poll_id: poll3.id)

AnswerChoice.destroy_all
answer_choice1 = AnswerChoice.create!(text: "Donald Trump", question_id: question1.id)
answer_choice2 = AnswerChoice.create!(text: "Joe Biden", question_id: question1.id)
answer_choice3 = AnswerChoice.create!(text: "Kamala Harris", question_id: question1.id)
answer_choice4 = AnswerChoice.create!(text: "Republican", question_id: question2.id)
answer_choice5 = AnswerChoice.create!(text: "Democrat", question_id: question2.id)
answer_choice6 = AnswerChoice.create!(text: "Independent", question_id: question2.id)
answer_choice7 = AnswerChoice.create!(text: "America", question_id: question3.id)
answer_choice8 = AnswerChoice.create!(text: "India", question_id: question3.id)
answer_choice9 = AnswerChoice.create!(text: "China", question_id: question3.id)
answer_choice10 = AnswerChoice.create!(text: "Egypt", question_id: question4.id)
answer_choice11 = AnswerChoice.create!(text: "Spain", question_id: question4.id)
answer_choice12 = AnswerChoice.create!(text: "Italy", question_id: question4.id)
answer_choice13 = AnswerChoice.create!(text: "Pizza", question_id: question5.id)
answer_choice14 = AnswerChoice.create!(text: "Pasta", question_id: question5.id)
answer_choice15 = AnswerChoice.create!(text: "Sushi", question_id: question5.id)
answer_choice16 = AnswerChoice.create!(text: "Water", question_id: question6.id)
answer_choice17 = AnswerChoice.create!(text: "Milk", question_id: question6.id)
answer_choice18 = AnswerChoice.create!(text: "Coffee", question_id: question6.id)
answer_choice19 = AnswerChoice.create!(text: "Greek", question_id: question7.id)
answer_choice20 = AnswerChoice.create!(text: "Plain", question_id: question7.id)
answer_choice21 = AnswerChoice.create!(text: "Blended", question_id: question7.id)

Response.destroy_all
#user1 responses
response1 = Response.create!(user_id: user1.id, question_id: question3.id, answer_choice_id: answer_choice7.id)
response2 = Response.create!(user_id: user1.id, question_id: question4.id, answer_choice_id: answer_choice10.id)
response3 = Response.create!(user_id: user1.id, question_id: question5.id, answer_choice_id: answer_choice15.id)
response4 = Response.create!(user_id: user1.id, question_id: question6.id, answer_choice_id: answer_choice16.id)
response5 = Response.create!(user_id: user1.id, question_id: question7.id, answer_choice_id: answer_choice19.id)
#user2 responses
response6 = Response.create!(user_id: user2.id, question_id: question1.id, answer_choice_id: answer_choice1.id)
response7 = Response.create!(user_id: user2.id, question_id: question2.id, answer_choice_id: answer_choice4.id)
response8 = Response.create!(user_id: user2.id, question_id: question5.id, answer_choice_id: answer_choice15.id)
response9 = Response.create!(user_id: user2.id, question_id: question6.id, answer_choice_id: answer_choice16.id)
#user3 responses
response10 = Response.create!(user_id: user3.id, question_id: question1.id, answer_choice_id: answer_choice2.id)
response11 = Response.create!(user_id: user3.id, question_id: question2.id, answer_choice_id: answer_choice5.id)
response12 = Response.create!(user_id: user3.id, question_id: question3.id, answer_choice_id: answer_choice7.id)
response13 = Response.create!(user_id: user3.id, question_id: question4.id, answer_choice_id: answer_choice12.id)




