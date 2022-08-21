#!/usr/bin/env ruby

require_relative '../lib/command'

begin
  Command.new(ARGV).run!
rescue CommandError => e
  puts e.message
end