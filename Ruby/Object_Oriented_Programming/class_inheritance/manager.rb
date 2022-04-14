require_relative 'employee'

class Manager < Employee 

    attr_reader :name 
    attr_accessor :employees

    def initialize(name, title, salary, boss)
        super 
        @employees = []
    end 

    def add_employee(employee)
        @employees << employee if employee.boss == name  
    end 

end 