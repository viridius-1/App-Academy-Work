# PHASE 2
def convert_to_int(str)
  Integer(str)
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else 
    raise StandardError 
  end 
end

def feed_me_a_fruit
  begin
    puts "Hello, I am a friendly monster. :)"
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue
    if maybe_fruit == 'coffee'
      puts "\nHey thanks, I like coffee so I'll let you try to feed me another fruit."
      retry 
    else 
      puts "Thanks, but I don't really like #{maybe_fruit}."
    end 
  end
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise "You can't be best friends with someone if you've known them for less than 5 years. Please enter 5 or greater for years known." if yrs_known < 5
    if name.length == 0 && fav_pastime.length == 0 
      raise "You entered nothing for your name and you and your best friend's favorite pastime. Please enter something for name and favorite pastime."
    elsif name.length == 0 
      raise "You entered nothing for your name. Please enter something for name." 
    elsif fav_pastime.length == 0 
      raise "You entered nothing for you and your best friend's favorite pastime. Please enter something for favorite pastime."  
    end 
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


