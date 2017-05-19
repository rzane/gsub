module Gsub
  class Scanner
    getter :matches, :replacements

    alias Matches = Hash(Int32, String)
    alias Replacements = Hash(Int32, String)
    alias Changeset = Hash(Int32, Tuple(String, String))

    def self.scan(path, pattern)
      scanner = new(pattern, File.read_lines(path))
      scanner.scan
      scanner
    end

    def initialize(@pattern : Regex, @lines = [] of String)
      @matches = Matches.new
      @replacements = Replacements.new
    end

    def changeset
      matches.reduce(Changeset.new) do |acc, (i, line)|
        acc[i] = {line, replacements[i]}
        acc
      end
    end

    def scan
      @lines.each_with_index do |line, i|
        if line =~ @pattern
          @matches[i] = line
        end
      end
    end

    def compile(replacement)
      matches.each do |i, line|
        @replacements[i] = line.gsub(@pattern, replacement)
      end
    end

    def commit(filename)
      File.open(filename, "w+") do |f|
        @lines.each_with_index do |line, i|
          f.puts replacements.fetch(i, line)
        end
      end
    end
  end
end
