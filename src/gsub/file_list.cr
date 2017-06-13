class Dir
  # I'm a very, very naughty boy.
  # See: https://github.com/crystal-lang/crystal/blob/5370fafdd8744c9f5b8443bc35c65fc6926d2341/src/dir/glob.cr#L108
  def self._expand_glob(glob)
    glob2regex(glob)
  end
end

module Gsub
  class FileList
    setter :includes, :exclude_patterns

    def initialize
      @includes = [Dir.current] of String
      @exclude_patterns = [] of Regex
    end

    def add(spec : String)
      @includes << spec
    end

    def remove(spec : String)
      @exclude_patterns << Dir._expand_glob(spec)
    end

    def each(&block : (String) ->)
      @includes.each do |glob|
        Dir.glob(glob) do |path|
          next if excluded?(path)
          next if binary?(path)
          yield path
        end
      end
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
