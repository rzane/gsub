require "colorize"

module Gsub
  struct View
    getter :config

    ARROW = "->".colorize(:blue)

    def initialize(@config : Gsub::Config)
    end

    def file(text)
      text.colorize(:green).bold
    end

    def line(number)
      (number + 1).to_s.colorize(:yellow)
    end

    def match(text)
      text.gsub(config.find) do |m|
        m.colorize(:black).on_yellow
      end
    end

    def replace(text)
      text.colorize(:light_red)
    end

    def matches(path : String, data : Scanner::Matchset)
      return if data.empty?
      puts file(path)

      data.each do |i, source|
        puts "#{line(i)}:#{match(source)}"
      end
    end

    def changeset(path : String, data : Scanner::Changeset)
      return if data.empty?
      puts file(path)

      data.each do |i, (source, replacement)|
        puts "#{line(i)}:#{match(source)} #{ARROW} #{replace(replacement)}"
      end
    end
  end
end
