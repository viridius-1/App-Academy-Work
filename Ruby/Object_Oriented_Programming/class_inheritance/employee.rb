class Employee 

    attr_reader :boss

    def initialize(name, title, salary, boss)
        @name = name 
        @title = title 
        @salary = salary 
        @boss = boss 
    end 

end 