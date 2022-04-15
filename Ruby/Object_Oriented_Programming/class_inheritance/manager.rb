require_relative 'employee'

class Manager < Employee 

    attr_reader :name, :salary 
    attr_accessor :employees

    def initialize(name, title, salary, boss)
        super 
        @employees = []
    end 

    def add_employee(employee)
        @employees << employee if employee.boss == name  
    end 

    def bonus(multiplier)
        all_subordinate_salaries * multiplier
    end 

    private 

    def all_subordinate_salaries
        salary_total = 0 

        workers = [self]
        until workers.empty?
            worker = workers.shift 
            salary_total += worker.salary if worker != self 
            if worker.class == Manager 
                worker.employees.each { |worker| workers << worker }
            end 
        end 

        salary_total
    end 

end 