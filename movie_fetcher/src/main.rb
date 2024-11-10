require_relative 'movies'
def main
  movie_title = "Atonement"
  puts Movies.fetch_by_title(movie_title).to_table
end

if __FILE__ == $0
  main
end