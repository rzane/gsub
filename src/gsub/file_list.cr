module Gsub
  class FileList
    property glob : String

    def initialize
      @glob = "**/*"
      @includes = [] of String
      @excludes = [] of String
    end

    def add(spec : String)
      @includes << spec
    end

    def remove(spec : String)
      @excludes << spec
    end

    def to_a
      files = load_glob(@glob)
      files += load_glob(@includes)
      files -= load_glob(@excludes)
      files
    end

    private def load_glob(spec : Array)
      spec.flat_map { |s| load_glob(s) }
    end

    private def load_glob(spec : String)
      Dir.glob(spec).reject { |path| File.directory?(path) }
    end
  end
end
