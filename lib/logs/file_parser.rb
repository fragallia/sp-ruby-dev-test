# frozen_string_literal: true

module Logs
  class FileParser
    def self.parsed_logs(path)
      return enum_for(:parsed_logs, path) unless block_given?

      File.readlines(path).each do |line|
        yield line.strip.split.then { |chunks| { path: chunks[0], ip: chunks[1] } }
      end
    end
  end
end
