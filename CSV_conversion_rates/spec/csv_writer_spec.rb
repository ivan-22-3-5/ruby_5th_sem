# frozen_string_literal: true
require_relative '../src/csv_writer'
include CSVWriter

RSpec.describe CSVWriter do
  describe '#write_csv' do
    let(:filename) { 'files/test_currency_rates.csv' }
    let(:header) { %w[Currency USD] }
    let(:data) { [['EUR', 1.12], ['GBP', 1.31]] }

    it 'creates a CSV file with correct content' do
      write_csv(filename, header, data)

      expect(File.exist?(filename)).to be true
      expect(File.read(filename)).to include('Currency,USD')
      expect(File.read(filename)).to include('EUR,1.12')
      expect(File.read(filename)).to include('GBP,1.31')

      File.delete(filename) if File.exist?(filename)
    end

    it 'raises an error if row length does not match header length' do
      invalid_data = [['EUR', 0.84], ['GBP']]

      expect {
        write_csv(filename, header, invalid_data)
      }.to raise_error(ArgumentError, 'All rows must have the same length as the header')
    end
  end
end