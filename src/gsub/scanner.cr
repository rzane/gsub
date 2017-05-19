module Gsub
  struct Scanner
    alias Matchset = Hash(Int32, String)
    alias Changeset = Hash(Int32, Tuple(String, String))

    def initialize(@path : String, @pattern : Regex)
    end

    def scan
      matchset = Matchset.new

      i = 0
      File.each_line(@path) do |line|
        matchset[i] = line if line =~ @pattern
        i += 1
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
      lines = File.read_lines(@path)

      File.open(filename, "w+") do |f|
        lines.each_with_index do |line, i|
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
