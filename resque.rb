#!/usr/bin/env ruby

require 'net/http'
require 'uri'

# The STATS_URL constant can be set as an environment variable
# when the script is called or in the plugin configuration

def stats_url
  @stats_url ||= ENV.fetch('STATS_URL', 'http://127.0.0.1/resque/stats.txt')
end

# Net::HTTP has the worst API ever, but it's in the standard lib

def raw_stats
  url = URI.parse(stats_url)
  Net::HTTP.start(url.host, url.port) {|http|
    http.request(Net::HTTP::Get.new(url.path))
  }.body
end

# Resque key/vales are parsed in a very simple way.
# The "+=" operation for "resque.failed" and "resque.processed"
# is not taken into account (yet) and the "+" stays in the key name.

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