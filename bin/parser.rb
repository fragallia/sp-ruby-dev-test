#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/command'

begin
  Command.new(ARGV).run!
rescue CommandError => e
  puts e.message
end
