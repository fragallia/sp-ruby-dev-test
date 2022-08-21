# frozen_string_literal: true

require 'optparse'

require_relative './logs/formater'
require_relative './logs/file_parser'

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

    Logs::Formater.new(page_views).lines.each { |line| puts line }

    puts
    puts 'List of webpages with most unique page views'
    puts

    Logs::Formater.new(page_unique_views).lines.each { |line| puts line }
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
    @stats ||= Logs::FileParser.parsed_logs(options[:file]).each_with_object({}) do |log, res|
      res[log[:path]] ||= {}
      res[log[:path]][log[:ip]] = res[log[:path]][log[:ip]].to_i + 1
    end
  end
end
