# frozen_string_literal: true
require 'rspec'
require 'webmock/rspec'

require_relative '../src/currency_rate_fetcher'
include CurrencyRateFetcher

RSpec.describe CurrencyRateFetcher do
  describe '.fetch_currency_rates' do
    context 'when the API request is successful' do
      before do
        stub_request(:get, /exchangerate-api/)
          .to_return(status: 200, body: { "conversion_rates" => { "USD" => 1.0, "EUR" => 0.85 } }.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns the conversion rates' do
        currency = "USD"
        rates = fetch_currency_rates(currency)
        expect(rates).to eq({ "USD" => 1.0, "EUR" => 0.85 })
      end
    end

    context 'when the API request fails' do
      before do
        stub_request(:get, /exchangerate-api/).to_return(status: 500)
      end

      it 'returns nil' do
        currency = "USD"
        rates = fetch_currency_rates(currency)

        expect(rates).to be_nil
      end
    end

    context 'when there is an HTTP error' do
      before do
        stub_request(:get, /exchangerate-api/).to_raise(HTTP::Error)
      end

      it 'rescues the error and returns nil' do
        currency = "USD"
        rates = fetch_currency_rates(currency)

        expect(rates).to be_nil
      end
    end
  end
end

