module Gsub
  struct Scanner
    alias Matchset = Hash(Int32, String)
    alias Changeset = Hash(Int32, Tuple(String, String))

    def self.read(pattern, path)
      new(pattern, File.read_lines(path))
    end

    def initialize(@pattern : Regex, @lines = [] of String)
    end

    def scan
      matchset = Matchset.new

      @lines.each_with_index do |line, i|
        matchset[i] = line if line =~ @pattern
      end

      matchset
    end

    def compile(replacement, matches : Matchset)
      matches.reduce(Changeset.new) do |acc, (i, line)|
        acc[i] = {line, line.gsub(@pattern, replacement)}
        acc
      end
    end

    def commit(filename, changeset : Changeset)
      File.open(filename, "w+") do |f|
        @lines.each_with_index do |line, i|
          if change = changeset[i]?
            f.puts change[1]
          else
            f.puts line
          end
        end
      end
    end
  end
end
