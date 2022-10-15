class AddIndexToResponseTable < ActiveRecord::Migration[5.2]
  def change
    add_index :responses, :user_id 
    add_index :responses, :question_id     
    add_index :responses, :answer_choice_id 
  end
end
