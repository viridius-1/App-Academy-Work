require 'sqlite3'
require 'singleton' 

class PlayDBConnection < SQLite3::Database 
     include Singleton 

     def initialize 
        super('plays.db')
        self.type_translation = true 
        self.results_as_hash = true 
     end 
end 


class Play
    attr_accessor :id, :playwright_id, :title, :year

    def self.all 
        data = PlayDBConnection.instance.execute("SELECT * FROM plays")
        data.map { |datum| Play.new(datum) }
    end 

    def self.find_by_title(title)
        data = PlayDBConnection.instance.execute("SELECT * FROM plays WHERE title = \"#{title}\"")
    end 

    def self.find_by_playwright(name)
        data = PlayDBConnection.instance.execute("
            SELECT 
                *
            FROM 
                plays 
            JOIN 
                playwrights ON plays.playwright_id = playwrights.id 
            WHERE 
                name = \"#{name}\" 
        ")
    end 

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @year = options['year']
        @playwright_id = options['playwright_id']
    end 

    def create
        raise "#{self} already in database" if !Play.find_by_title(title).empty? 
        PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
            INSERT INTO
                plays (title, year, playwright_id)
            VALUES
                (?, ?, ?)
        SQL
        @id = PlayDBConnection.instance.last_insert_row_id 
    end 

    def update
        raise "#{self} not in database" if Play.find_by_title(title).empty? 
        PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
            UPDATE
                plays
            SET
                title = ?, year = ?, playwright_id = ?
            WHERE
                id = ?
        SQL
    end
end 


class Playwright 
    attr_accessor :birth_year, :id, :name 

    def self.all 
        data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
        data.map { |datum| Playwright.new(datum) }
    end 

    def self.find_by_name(name)
        data = PlayDBConnection.instance.execute("SELECT * FROM playwrights WHERE name = \"#{name}\"")
    end 

    def initialize(options)
        @id = options['id']
        @name = options['name']
        @birth_year = options['birth_year']
    end 

    def create 
        raise "#{self} already in database" if !Playwright.find_by_name(name).empty? 
        PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
            INSERT INTO 
                playwrights (name, birth_year)
            VALUES
                (?, ?)
        SQL
        @id = PlayDBConnection.instance.last_insert_row_id 
    end 

    def update 
        raise "#{self} not in database" if Playwright.find_by_name(name).empty? 
        PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
            UPDATE
                playwrights
            SET
                name = ?, birth_year = ?
            WHERE
                id = ?
        SQL
    end 

    def get_plays
        Play.find_by_playwright(name)
    end 
end 

