require 'rspec'
require 'webmock/rspec'
require_relative '../src/movies'

RSpec.describe Movies do
  let(:movie_data) do
    {
      'Title' => 'Inception',
      'Released' => '16 Jul 2010',
      'Runtime' => '148 min',
      'imdbRating' => '8.8',
      'Genre' => 'Action, Adventure, Sci-Fi',
      'Director' => 'Christopher Nolan',
      'Writer' => 'Christopher Nolan',
      'Actors' => 'Leonardo DiCaprio, Joseph Gordon-Levitt, Ellen Page',
      'Language' => 'English, Japanese, French',
      'Country' => 'USA, UK',
      'Response' => 'True'
    }
  end

  describe '.fetch_by_title' do
    context 'when the API response is valid' do
      before do
        stub_request(:get, "#{Movies::BASE_URL}t=inception")
          .to_return(body: movie_data.to_json, status: 200, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns a movie object with the correct attributes' do
        result = Movies.fetch_by_title('inception')
        expect(result).to be_a(Movies::Movie)
        expect(result.title).to eq('Inception')
        expect(result.released).to eq('16 Jul 2010')
        expect(result.imdb_rating).to eq('8.8')
      end
    end

    context 'when the API response is invalid' do
      before do
        stub_request(:get, "#{Movies::BASE_URL}t=InvalidMovie")
          .to_return(body: { "Response" => "False", "Error" => "Movie not found!" }.to_json, status: 200)
      end

      it 'returns nil' do
        result = Movies.fetch_by_title('InvalidMovie')
        expect(result).to be_nil
      end
    end

    context 'when the API call fails' do
      before do
        stub_request(:get, "#{Movies::BASE_URL}t=Inception")
          .to_raise(HTTP::Error)
      end

      it 'returns nil' do
        result = Movies.fetch_by_title('Inception')
        expect(result).to be_nil
      end
    end
  end
end