require "option_parser"
require "./config"
require "./runner"

module Gsub
  def self.help(opts)
    puts "Options:"
    puts opts
    exit
  end

  def self.run
    config = Config.new

    OptionParser.parse! do |opts|
      opts.on("-g", "--glob [glob]", "Where shall I search?") { |v| config.files.glob = v }
      opts.on("-i", "--include [glob]", "Should I include other files?") { |v| config.files.add(v) }
      opts.on("-e", "--exclude [glob]", "Should I exclude some files?") { |v| config.files.remove(v) }
      opts.on("-f", "--find [pattern]", "What pattern should I find?") { |v| config.find = v }
      opts.on("-r", "--replace [pattern]", "What pattern shall I replace?") { |v| config.replace = v }
      opts.on("-c", "--commit", "Should I save the replacements?") { config.commit = true }
      opts.on("-h", "--help", "We've all been there...") { help(opts) }
    end

    config.validate!
    runner = Runner.new(config)
    runner.run
  end
end

begin
  Gsub.run
rescue ex : OptionParser::InvalidOption
  abort ex.message
rescue ex : Gsub::Config::InvalidError
  abort ex.message
end
