# frozen_string_literal: true

require 'optparse'

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

    puts 'List of webpages with most page views'
    puts

    page_views.each { |item| puts item.join(' ') }

    puts
    puts 'List of webpages with most unique page views'
    puts

    page_unique_views.each { |item| puts item.join(' ') }
  rescue OptionParser::InvalidOption => e
    raise CommandError, e.message
  end

  private

  def page_unique_views
    stats.map { |page, ips| [page, ips.values.max, 'unique views'] }
         .sort_by { |item| item[1] }
         .reverse
  end

  def page_views
    stats.map { |page, ips| [page, ips.values.sum, 'visits'] }
         .sort_by { |item| item[1] }
         .reverse
  end

  def stats
    @stats ||= logs.each_with_object({}) do |log, res|
      res[log[:path]] ||= {}
      res[log[:path]][log[:ip]] = res[log[:path]][log[:ip]].to_i + 1
    end
  end

  def logs
    @logs ||= File.readlines(options[:file]).map do |line|
      line.strip.split.then { |chunks| { path: chunks[0], ip: chunks[1] } }\
    end
  end
end
