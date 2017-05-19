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

    def process(path : String)
      scanner = Scanner.read(config.find, path)
      matches = scanner.scan

      if config.replace?
        changeset = scanner.compile(config.replace, matches)
        @view.changeset(path, changeset)
        scanner.commit(path, changeset) if config.commit?
      else
        @view.matches(path, matches)
      end
    end
  end
end
