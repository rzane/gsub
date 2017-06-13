module Gsub
  class FileList
    include Enumerable(String)

    def initialize
      @includes = [] of String
      @exclude_patterns = [] of Regex
    end

    def add(spec : String)
      if spec =~ /\*/
        @includes << spec
      else
        @includes << "#{spec}/**/*"
      end
    end

    def remove(spec : String)
      @exclude_patterns << Regex.new(spec)
    end

    def fallback_to(spec : String)
      add(spec) if @includes.empty?
    end

    def each(&block : (String) ->)
      @includes.each do |glob|
        Dir.glob(glob) do |path|
          next if directory?(path)
          next if hidden?(path)
          next if excluded?(path)
          next if binary?(path)
          yield path
        end
      end
    end

    def directory?(path)
      File.directory?(path)
    end

    def hidden?(path)
      File.basename(path) =~ /^\./
    end

    def excluded?(path)
      @exclude_patterns.any? do |exclude|
        exclude =~ path
      end
    end

    # Returns true if the file includes a null byte
    # in the first 4096 chars
    def binary?(path)
      file = File.new(path)
      file.set_encoding("US-ASCII", invalid: :skip)

      0.upto(4096).any? do
        char = file.read_char
        break false unless char
        char == 0.chr
      end
    end
  end
end
