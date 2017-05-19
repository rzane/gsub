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
        Process.run("find", find_args(glob)) do |process|
          process.output.each_line(&block)
        end
      end
    end

    private def find_args(glob)
      [glob, "-type", "f"] + skip_excludes + skip_binaries
    end

    private def skip_excludes
      @excludes.flat_map do |exclude|
        ["-not", "(", "-path", exclude, "-prune", ")"]
      end
    end

    private def skip_binaries
      ["-exec", "grep", "-Iq", ".", "{}", ";", "-and", "-print"]
    end
  end
end
