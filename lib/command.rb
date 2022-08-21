# frozen_string_literal: true

require 'optparse'

require_relative './logs/formater'
require_relative './logs/file_parser'
require_relative './logs/stats'

class CommandError < StandardError; end

class Command
  attr_accessor :args, :options

  def initialize(args)
    @args = args
    @options = {}
  end

  def run!
    option_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: bin/parser.rb [options]'

      opts.on('-f', '--file PATH_TO_FILE', 'Log file') do |v|
        options[:file] = v
      end
      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end

    option_parser.parse(args)

    if options.empty?
      puts option_parser
      exit
    end

    stats = Logs::Stats.new(Logs::FileParser.parsed_logs(options[:file]))

    puts 'List of webpages with most page views'
    puts

    Logs::Formater.new(stats.page_views).lines.each { |line| puts line }

    puts
    puts 'List of webpages with most unique page views'
    puts

    Logs::Formater.new(stats.page_unique_views).lines.each { |line| puts line }
  rescue OptionParser::InvalidOption => e
    raise CommandError, e.message
  end
end
