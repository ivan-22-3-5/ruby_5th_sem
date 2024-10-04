# frozen_string_literal: true

def ipv4?(ip)
    ip.instance_of?(String) &&
    ip.match?(/^\d+\.\d+\.\d+\.\d+$/) &&
    ip.split('.').all? { |x|
        (!x.start_with?('0') || x.length == 1) && x.to_i.between?(0, 255)}
end