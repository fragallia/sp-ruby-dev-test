require 'optparse'

class Command
  attr_reader :args
  def initialize(args)
    @args = args
  end

  def run!
    options = {}
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: bin/parser.rb [options]"

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opts.parse(args)

    if options.empty?
      puts opts
      exit
    end
  end
end