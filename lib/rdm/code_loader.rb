require 'zeitwerk'
require 'singleton'

class Rdm::CodeLoader
  include Singleton

  def initialize
    @loader = Zeitwerk::Loader.new
  end

  def push_dir(path)
    @loader.push_dir(path)
    puts @loader.dirs
  end

  def setup
    @loader.setup
  end

  def eager_load
    @loader.eager_load
  end
end