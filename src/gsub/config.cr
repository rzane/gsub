require "./file_list"

module Gsub
  class Config
    class InvalidError < Exception
    end

    setter find : String
    setter commit : Bool
    getter files : FileList
    property replace : String?

    def initialize
      @find = ""
      @replace = nil
      @commit = false
      @files = FileList.new
    end

    def find
      Regex.new(@find)
    end

    def replace?
      !replace.nil?
    end

    def commit?
      replace? && @commit
    end

    def validate!
      if @find.blank?
        raise InvalidError.new("You didn't specify a pattern to --find.")
      end
    end
  end
end
