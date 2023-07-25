require "zeitwerk"
loader = Zeitwerk::Loader.for_gem

loader.inflector.inflect(
  "cli" => "CLI"
)

loader.setup

module Rdm
  SOURCE_FILENAME = 'Rdm.packages'.freeze
  PACKAGE_FILENAME = 'Package.rb'.freeze

  extend Rdm::Helpers::PathHelper

  class << self
    # Initialize current package using Package.rb
    def init(package_path, group = nil, stdout: $stdout)
      @stdout = stdout

      Rdm::PackageImporter.import_file(package_path, group: group)
    end

    # Rdm's internal settings
    def settings
      @settings ||= Rdm::Settings.new
    end

    # Rdm's managed configuration
    def config
      @config ||= Rdm::ConfigManager.new
    end

    # Setup Rdm's internal settings
    def setup(&block)
      settings.instance_eval(&block) if block_given?
    end

    def root=(value)
      if @root && @root != value
        @stdout.puts "Rdm has already been initialized and Rdm.root was set to #{@root}"
      end
      @root = value
    end

    def root(path = nil)
      return @root if @root

      if path
        @root = Rdm::SourceLocator.locate(path)
      end

      @root
    end

    def root_dir
      if !root
        raise ArgumentError, "Rdm.root is not initialized. Run Rdm.root(ANY_PROJECT_FILE_PATH) to init it"
      end

      File.dirname(root)
    end
  end
end
