# frozen_string_literal: true
require_relative '../src/ip_validator'

RSpec.describe 'ip_valid?' do
  context 'when the IP is valid' do
    it 'returns true for valid IPv4 addresses' do
      expect(ipv4?('192.168.1.2')).to eq(true)
      expect(ipv4?('0.0.0.0')).to eq(true)
      expect(ipv4?('1.1.1.1')).to eq(true)
      expect(ipv4?('255.255.255.255')).to eq(true)
      expect(ipv4?('9.8.9.8')).to eq(true)
      expect(ipv4?('54.54.54.54')).to eq(true)
      expect(ipv4?('10.0.1.1')).to eq(true)
      expect(ipv4?('1.2.3.4')).to eq(true)
    end
  end

  context 'when the IP is invalid' do
    it 'returns false for IPs with fewer than 4 octets' do
      expect(ipv4?('192.168.1')).to eq(false)
    end

    it 'returns false for IPs with more than 4 octets' do
      expect(ipv4?('192.168.1.1.1')).to eq(false)
    end

    it 'returns false for octets greater than 255' do
      expect(ipv4?('256.168.1.1')).to eq(false)
    end

    it 'returns false for octets less than 0' do
      expect(ipv4?('-1.168.1.1')).to eq(false)
    end

    it 'returns false for non-numeric octets' do
      expect(ipv4?('abc.def.ghi.jkl')).to eq(false)
    end

    it 'returns false for empty string' do
      expect(ipv4?('')).to eq(false)
    end

    it 'returns false for non-string input types' do
      expect(ipv4?(nil)).to eq(false)
      expect(ipv4?(12345)).to eq(false)
      expect(ipv4?([])).to eq(false)
    end

    it 'returns false for octets with leading zeroes' do
      expect(ipv4?('192.168.01.1')).to eq(false)
    end

    it 'returns false for octets with excessive length' do
      expect(ipv4?('192.168.1234.1')).to eq(false)
    end

    it 'returns false for extra spaces around the IP' do
      expect(ipv4?(' 192.168.1.1 ')).to eq(false)
      expect(ipv4?('192 .168.1.1')).to eq(false)
    end

    it 'returns false for an IP with trailing dots' do
      expect(ipv4?('192.168.1.1.')).to eq(false)
      expect(ipv4?('.192.168.1.1')).to eq(false)
    end

    it 'returns false for IPs with characters mixed with numbers' do
      expect(ipv4?('192.16a.1.1')).to eq(false)
    end

    it 'returns false for an IP with just dots' do
      expect(ipv4?('....')).to eq(false)
    end

    it 'returns false for IPs with missing octets' do
      expect(ipv4?('192..1.1')).to eq(false)
    end

    it 'returns false for IPs with port ' do
      expect(ipv4?('192.168.1.1:8080')).to eq(false)
    end
  end
end