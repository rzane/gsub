module Gsub
  struct View
    def initialize(@config : Gsub::Config)
    end

    def matches(path : String, data : Scanner::Matchset)
      puts path unless data.empty?

      data.each do |i, source|
        puts "#{i}: #{source}"
      end
    end

    def changeset(path : String, data : Scanner::Changeset)
      puts path unless data.empty?

      data.each do |i, (source, replacement)|
        puts "#{i}: #{source} -> #{replacement}"
      end
    end
  end
end
