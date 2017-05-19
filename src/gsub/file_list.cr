module Gsub
  class FileList
    GLOB = "**/*"

    setter :includes, :excludes

    def initialize
      @includes = [Dir.current] of String
      @excludes = [] of String
    end

    def add(spec : String)
      @includes << spec
    end

    def remove(spec : String)
      @excludes << spec
    end

    def to_a
      expand(@includes) - expand(@excludes)
    end

    private def expand(specs : Array)
      specs.flat_map do |spec|
        if File.directory?(spec)
          expand_directory(spec)
        else
          Dir.glob(spec)
        end
      end
    end

    private def expand_directory(spec : String)
      Dir.glob(File.join(spec, GLOB)).reject do |path|
        File.directory?(path)
      end
    end
  end
end
