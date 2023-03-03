# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

require 'action_view'

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    CAT_COLORS = ["black", "grey", "mix", "orange", "white"]
    
    validates :birth_date, :color, :name, :sex, presence: true
    validates :color, :inclusion => { :in => CAT_COLORS, :message => "%{value} is not a valid color. Choose 'black', 'grey', 'mix', 'orange', or 'white'." }
    validates :sex, :inclusion => { :in => %w(M F), :message => "%{value} is not a valid sex. Choose 'M' or 'F'." }
    validate :birth_date_cannot_be_future

    def age 
        raise future_birth_date_error if birth_date_in_future?
        
        return age_in_days if cat_born_this_year_this_month? 

        years_old, months_old = get_initial_years_old_and_months_old_values
        years_old, months_old = adjust_years_old_and_months_old_values(years_old, months_old)
        years_old_word, months_old_word = get_years_old_word_and_months_old_word(years_old, months_old)

        compose_age_string(years_old, months_old, years_old_word, months_old_word)
    end 

    private 

    def birth_date_cannot_be_future 
        errors.add(:birth_date, "can't be in future.") if birth_date > Date.current
    end 

    def birth_date_in_future? 
        birth_date.year > Date.current.year || (birth_date.year == Date.current.year && birth_date.month > Date.current.month) || (birth_date.year == Date.current.year && birth_date.month == Date.current.month && birth_date.day > Date.current.day)  
    end 

    def future_birth_date_error
        "A cat can't have a birth date in the future. Please set the birth date to a date in the past."
    end 

    def cat_born_this_year_this_month? 
        Date.current.year == birth_date.year && Date.current.month == birth_date.month 
    end 

    def age_in_days 
        days_old = Date.current.day - birth_date.day
        if days_old == 1 
            "1 day old"
        else 
            "#{days_old} days old"
        end
    end 

    def get_initial_years_old_and_months_old_values
        years_old = Date.current.year - birth_date.year 
        months_old = Date.current.month - birth_date.month 
        [years_old, months_old]
    end 

    def adjust_years_old_and_months_old_values(years_old, months_old)
        if months_old < 0 
            months_old += 12 
            years_old -= 1 
        end 
        [years_old, months_old]
    end 

    def get_years_old_word_and_months_old_word(years_old, months_old)
        if months_old == 1 
            months_old_word = "month"
        else
            months_old_word = "months"
        end 

        if years_old == 1 
            years_old_word = "year"
        else 
            years_old_word = "years"
        end 

        [years_old_word, months_old_word]
    end 

    def compose_age_string(years_old, months_old, years_old_word, months_old_word)
        age_string = ""
        age_string += "#{years_old} #{years_old_word} " if years_old > 0 
        age_string += "#{months_old} #{months_old_word} " if months_old > 0 
        age_string += "old"
        age_string
    end 
end 
