# frozen_string_literal: true
require 'http'
require 'dotenv/load'
require_relative 'currency_rate_fetcher'
require_relative 'csv_writer'

include CurrencyRateFetcher
include CSVWriter

def main
  currencies = %w[USD EUR JPY GBP]
  data = []
  currencies.each do |currency|
    currency_rates = fetch_currency_rates(currency)
    data << {currency: currency}.merge(currency_rates.sort_by { |key, _| key }.to_h) if currency_rates
  end

  header = data.first.keys
  write_csv("files/currency_rates.csv", header, data.map { |row| row.values }.to_a)
end

if __FILE__ == $0
  main
end