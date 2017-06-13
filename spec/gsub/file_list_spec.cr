require "../spec_helper"
require "../../src/gsub/file_list"

describe Gsub::FileList do
  it "finds files in directory" do
    files = Fixtures.make [
      "a/file.txt", # yup
      "b/file.txt", # nope
    ]

    list = Gsub::FileList.new
    list.add Fixtures.join("a")
    list.to_a.should eq(files.first(1))
  end

  it "accepts globs" do
    files = Fixtures.make [
      "a/thing.txt",      # yup
      "b/deep/thing.txt", # yup
      "b/shallow.txt",    # yup
      "a/thing.log",      # nope
      "a/deep/thing.txt", # nope
    ]

    list = Gsub::FileList.new
    list.add Fixtures.join("a/*.txt")
    list.add Fixtures.join("b/**/*.txt")
    list.to_a.should eq(files.first(3))
  end

  it "excludes" do
    files = Fixtures.make [
      "a/thing.txt",      # yup
      "b/deep/thing.txt", # yup
      "b/shallow.txt",    # nope
      "a/thing.log",      # nope
      "a/deep/thing.txt", # nope
    ]

    list = Gsub::FileList.new
    list.add Fixtures.join("a/*.txt")
    list.add Fixtures.join("b/**/*.txt")
    list.remove Fixtures.join("b/shallow.txt")
    list.to_a.should eq(files.first(2))
  end

  it "excludes hidden files" do
    files = Fixtures.make [
      "foo/a.txt",  # yup
      "foo/.b.txt", # nope
    ]

    list = Gsub::FileList.new
    list.add Fixtures.join("foo/*.txt")
    list.to_a.should eq(files.first(1))
  end
end
