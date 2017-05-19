module Gsub
  struct View
    def initialize(@config : Gsub::Config)
    end

    def matches(path, data)
      puts path

      data.each do |i, source|
        puts "#{i}: #{source}"
      end
    end

    def changeset(path, data)
      puts path

      data.each do |i, (source, replacement)|
        puts "#{i}: #{source} -> #{replacement}"
      end
    end
  end
end
