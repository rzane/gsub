module Gsub
  class FileList
    setter :includes, :excludes

    def initialize
      @includes = [Dir.current] of String
      @excludes = [] of Regex
    end

    def add(spec : String)
      @includes << spec
    end

    def remove(spec : String)
      @excludes << Regex.new(spec)
    end

    def each(&block : (String) ->)
      @includes.each do |glob|
        if glob =~ /\*/
          normal_glob(glob).each(&block)
        else
          incremental_glob(glob, &block)
        end
      end
    end

    private def exclude?(file)
      @excludes.any? { |ex| file =~ ex }
    end

    private def normal_glob(glob)
      Dir.glob(glob).reject do |f|
        File.directory?(f) || exclude?(f)
      end
    end

    private def incremental_glob(glob, &block : (String) ->)
      if File.directory?(glob)
        Dir.glob(File.join(glob, "*")).each do |path|
          incremental_glob(path, &block)
        end
      elsif !exclude?(glob)
        block.call(glob)
      end
    end
  end
end
