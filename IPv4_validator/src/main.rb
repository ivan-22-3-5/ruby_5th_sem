# frozen_string_literal: true

require_relative 'ip_validator'

def main
  puts "Enter a string: "
  puts "Your string is #{"not " unless ipv4?(gets.chomp)}an IPv4 address"
end

if __FILE__ == $0
  main
end