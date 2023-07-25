class Factory::SampleFactory
  def perform
    puts "Repository::SampleRepository called..."
    config = Rdm.config
    puts "WORKS! (#{config.app_name})"
  end
end
