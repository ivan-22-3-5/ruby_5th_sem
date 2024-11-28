# frozen_string_literal: true

require 'rspec'
require_relative '../src/dictionary'

RSpec.describe Dictionary do
  describe '#+' do
    it 'combines two dictionaries without modifying the originals' do
      dict1 = Dictionary.new({ a: 1, b: 2 })
      dict2 = Dictionary.new({ b: 3, c: 4 })

      result = dict1 + dict2

      expect(result.data).to eq({ a: 1, b: 3, c: 4 })
      expect(dict1.data).to eq({ a: 1, b: 2 })
      expect(dict2.data).to eq({ b: 3, c: 4 })
    end

    it 'handles merging with empty dictionaries correctly' do
      dict1 = Dictionary.new({ a: 1, b: 2 })
      dict2 = Dictionary.new({})

      result = dict1 + dict2

      expect(result.data).to eq({ a: 1, b: 2 })
    end

    it 'handles both dictionaries being empty' do
      dict1 = Dictionary.new({})
      dict2 = Dictionary.new({})

      result = dict1 + dict2

      expect(result.data).to eq({})
    end

    it 'handles dictionaries with no overlapping keys' do
      dict1 = Dictionary.new({ a: 1 })
      dict2 = Dictionary.new({ b: 2 })

      result = dict1 + dict2

      expect(result.data).to eq({ a: 1, b: 2 })
    end

    it 'gives precedence to the second dictionary in case of duplicate keys' do
      dict1 = Dictionary.new({ a: 1, b: 2 })
      dict2 = Dictionary.new({ b: 5, c: 3 })

      result = dict1 + dict2

      expect(result.data).to eq({ a: 1, b: 5, c: 3 })
    end
  end
end

