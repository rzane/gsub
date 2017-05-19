require "./config"
require "./scanner"
require "./view"

module Gsub
  struct Runner
    getter config

    def initialize(@config : Gsub::Config)
      @view = View.new(config)
    end

    def run
      config.files.to_a.each do |path|
        process(path)
      end
    end

    def process(path)
      scanner = Scanner.scan(path, config.find)

      if config.replace?
        scanner.compile(config.replace)
        @view.changeset(path, scanner.changeset)
        scanner.commit(path) if config.commit?
      else
        @view.matches(path, scanner.matches)
      end
    end
  end
end
