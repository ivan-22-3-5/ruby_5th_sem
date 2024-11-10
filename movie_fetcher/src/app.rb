require 'thor'
require_relative 'movies'
class App < Thor
  desc "find [MOVIE_TITLE]", "trying to find a movie by title"

  def find(title)
    movie = Movies.fetch_by_title(title)
    if movie.nil?
      puts "Movie not found"
    else
      puts movie.to_table
    end
  end

  def self.exit_on_failure?
    false
  end
end