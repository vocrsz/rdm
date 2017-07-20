class Rdm::SourceComposer
  def self.run(source, root)
    Rdm::SourceComposer.new(source, root).run
  end

  def initialize(source, root)
    @source  = source
    @root    = root
    @content = []
  end

  def run
    @content.push "setup do"
    Rdm.settings.settings.each do |setting, value|
      @content.push "  #{setting} #{format_value(value)}"
    end
    @content.push "end"
    
    @content.push "\n"

    @source.config_names.each do |config, _|
      @content.push "config :#{config}"
    end

    @content.push "\n"

    @source.package_paths.each do |package, _|
      @content.push "package \"#{package}\""
    end

    File.open(Rdm.root(@root), 'w') {|f| f.puts @content}
  end

  def format_value(value)
    return "\"#{value}\""  if value.is_a?(String)
    
    value.to_s
  end
end