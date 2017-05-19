require "colorize"

module Gsub
  struct View
    getter :config

    def initialize(@config : Gsub::Config)
    end

    def filename(text)
      text.sub(/^\.\//, "")
          .sub(/^#{Dir.current}\//, "")
          .colorize(:green).bold
    end

    def match(number, text)
      source = text.gsub(config.find) do |m|
        m.colorize(:black).on_yellow
      end

      "#{(number + 1).to_s.colorize(:yellow)}:#{source}"
    end

    def replace(number, text)
      space = " " * (number.to_s.chars.size + 1)
      "#{space}#{text.colorize(:magenta)}"
    end

    def matches(path : String, data : Scanner::Matchset)
      return if data.empty?
      puts filename(path)

      data.each do |i, source|
        puts match(i, source)
      end

      puts
    end

    def changeset(path : String, data : Scanner::Changeset)
      return if data.empty?
      puts filename(path)

      data.each do |i, (source, replacement)|
        puts match(i, source)
        puts replace(i, replacement)
      end

      puts
    end
  end
end
