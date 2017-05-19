module Gsub
  class FileList
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

    def each(&block : (String) ->)
      @includes.each do |glob|
        if glob =~ /\*/
          Dir.glob(glob).each(&block)
        else
          expand(glob, &block)
        end
      end
    end

    private def expand(glob, &block : (String) ->)
      if File.directory?(glob)
        Dir.glob(File.join(glob, "*")).each do |path|
          expand(path, &block)
        end
      else
        block.call(glob)
      end
    end
  end
end
