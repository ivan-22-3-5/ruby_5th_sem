require 'http'
require 'dotenv/load'
require 'terminal-table'

module Movies
  BASE_URL = "http://www.omdbapi.com?apikey=#{ENV['API_KEY']}&"

  class Movie
    ATTRIBUTES = {
      title: 'Title',
      released: 'Released',
      runtime: 'Runtime',
      imdb_rating: 'imdbRating',
      genre: 'Genre',
      director: 'Director',
      writer: 'Writer',
      actors: 'Actors',
      language: 'Language',
      country: 'Country'
    }.freeze

    attr_reader(*ATTRIBUTES.keys)

    def initialize(data)
      ATTRIBUTES.each do |attribute, key|
        instance_variable_set("@#{attribute}", data[key])
      end
    end

    def to_table
      table = Terminal::Table.new do |t|
        ATTRIBUTES.each do |attribute, key|
          t << [key, send(attribute)]
        end
      end
      table.style = { :border => :unicode_thick_edge }
      table
    end
  end

  def self.fetch_by_title(title)
    response = HTTP.get("#{BASE_URL}t=#{title}")
    parsed_response = response.parse
    return parsed_response["Response"] == "True" ? Movie.new(parsed_response) : nil
  end
end