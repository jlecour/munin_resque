#!/usr/bin/env ruby

require 'net/http'
require 'uri'

def stats_url
  @stats_url ||= ENV.fetch('STATS_URL', 'http://127.0.0.1/resque/stats.txt')
end

def raw_stats
  url = URI.parse(stats_url)
  Net::HTTP.start(url.host, url.port) {|http|
    http.request(Net::HTTP::Get.new(url.path))
  }.body
end

def stats
  @stats ||= begin
    hash_stats ||= {}
    raw_stats.each_line { |line|
      big_key, value = line.chomp.split('=')
      group, key = big_key.split('.')
      hash_stats[group] ||= {}
      hash_stats[group][key] = value
    }

    hash_stats
  end
end