require_relative '../src/utils'

RSpec.describe Utils do
  describe '.my_reverse' do
    it 'reverses an array of integers' do
      expect(Utils.my_reverse([1, 2, 3, 4])).to eq([4, 3, 2, 1])
    end

    it 'reverses an array of strings' do
      expect(Utils.my_reverse(%w[a b c])).to eq(%w[c b a])
    end

    it 'returns an empty array when given an empty array' do
      expect(Utils.my_reverse([])).to eq([])
    end

    it 'returns the same array when there is only one element' do
      expect(Utils.my_reverse([42])).to eq([42])
    end
  end
end