# frozen_string_literal: true
require 'dotenv/load'

module CurrencyRateFetcher
  BASE_URL = "https://v6.exchangerate-api.com/v6/#{ENV['API_KEY']}/latest/"

  def fetch_currency_rates(currency)
    begin
      response = HTTP.get("#{BASE_URL}#{currency}")
      return response.status.success? ? response.parse["conversion_rates"] : nil
    rescue HTTP::Error
      return nil
    end
  end
end
