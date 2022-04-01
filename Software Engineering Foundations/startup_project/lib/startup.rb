require "employee"

class Startup 

    attr_reader :name, :funding, :salaries, :employees 

    def initialize(name, funding, salaries)
        @name = name 
        @funding = funding 
        @salaries = salaries 
        @employees = []
    end 

    def valid_title?(title)
        @salaries.keys.include?(title)
    end 

    def >(startup2)
        @funding > startup2.funding 
    end 

    def hire(name, title)
        if self.valid_title?(title)
            @employees << Employee.new(name, title)
        else 
            raise "invalid title"
        end 
    end 

    def size 
        @employees.length 
    end 

    def pay_employee(employee)
        employee_salary = @salaries[employee.title]

        if @funding > employee_salary 
            employee.pay(employee_salary) 
            @funding -= employee_salary 
        else 
            raise "there are not enough startup funds to pay the employee"
        end 
    end 

    def payday
        @employees.each { |employee| self.pay_employee(employee) } 
    end 

    def average_salary
        all_salaries = 0 
        @employees.each { |employee| all_salaries += @salaries[employee.title] } 
        all_salaries / @employees.length 
    end 

    def close 
        @employees = []
        @funding = 0 
    end 

    def acquire(startup2)
        @funding += startup2.funding 
        
        salaries_startup2 = startup2.salaries 

        salaries_startup2.each do |title, pay| 
            if !@salaries.keys.include?(title) 
                @salaries[title] = pay 
            end 
        end 

        @employees += startup2.employees

        startup2.close 
    end 

end 
