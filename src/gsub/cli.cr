require "option_parser"
require "./config"
require "./runner"

module Gsub
  def self.help(opts)
    puts "Usage:"
    puts "  gsub [find] [paths...] [options]"
    puts "Options:"
    puts opts
    exit
  end

  def self.run(argv)
    config = Config.new

    OptionParser.parse! do |opts|
      opts.on("-e", "--exclude [glob]", "Should I exclude some files?") { |v| config.files.remove(v) }
      opts.on("-r", "--replace [pattern]", "What pattern shall I replace?") { |v| config.replace = v }
      opts.on("-c", "--commit", "Should I save the replacements?") { config.commit = true }
      opts.on("-h", "--help", "We've all been there...") { help(opts) }

      opts.unknown_args do |args, _options|
        config.find = args[0] if args.size > 0
        config.files.includes = args[1..-1] if args.size > 1
      end
    end

    config.validate!
    runner = Runner.new(config)
    runner.run
  end
end

begin
  Gsub.run(ARGV)
rescue ex : OptionParser::InvalidOption
  abort ex.message
rescue ex : Gsub::Config::InvalidError
  abort ex.message
end
