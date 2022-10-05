def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.select('movies.id', 'movies.title').joins(:actors).where(actors: {name: those_actors}).group('movies.title', 'movies.id').having('COUNT(*) = ?', those_actors.length)
end 

def golden_age
  # Find the decade with the highest average movie score.
  Movie.select('(yr/10)*10 AS decade', 'AVG(score) AS avg_movie_score').group(:decade).order('avg_movie_score DESC').first.decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  movie_ids_of_actor = []

  #subquery to get data of named actor with movie_ids corresponding to movies they've been in
  movie_ids_of_actor_data = Actor.select('castings.movie_id').joins(:castings).where(name: name)
  
  #fill array of only movie_ids
  movie_ids_of_actor_data.each { |record| movie_ids_of_actor << record.movie_id } 

  #query to get actors that named actor has appeared with 
  Actor.joins(:castings).where('castings.movie_id IN (?)', movie_ids_of_actor).where('actors.name != ?', name).pluck('distinct name')
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.eager_load(:movies).where('castings.actor_id IS NULL').count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. 'Sylvester Stallone' is like 'sylvester' and 'lester stone' but
  # not like 'stallone sylvester' or 'zylvester ztallone'

  matcher = "%#{whazzername.split(//).join('%')}%" 
  # the `//` in line above is creating an empty regex expression, or an empty string
  # splitting on the `//` here is the same as splitting on an empty string

  Movie.joins(:actors).where('UPPER(actors.name) LIKE UPPER(?)', matcher)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor.select('actors.id, actors.name, MAX(movies.yr) - MIN(movies.yr) AS career').joins(:movies).group('actors.id').order('career DESC, actors.name').limit(3)
end
