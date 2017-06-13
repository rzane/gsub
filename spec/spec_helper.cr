require "spec"
require "file_utils"

module Fixtures
  ROOT = "/tmp/gsub-fixtures"

  extend self

  def root
    ROOT
  end

  def clean
    FileUtils.rm_rf ROOT
  end

  def join(*paths)
    File.join(ROOT, *paths)
  end

  def make(paths)
    paths.map do |path|
      make(ROOT, path)
    end
  end

  def make(root, path : String)
    make(root, {path, "x" * 30})
  end

  def make(root, path : Tuple(String, String))
    filename = File.join(root, path[0])
    FileUtils.mkdir_p File.dirname(filename)
    File.write(filename, path[1])
    filename
  end
end

Spec.before_each do
  Fixtures.clean
end
