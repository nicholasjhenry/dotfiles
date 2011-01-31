unless defined? ETC_IRBRC_LOADED

  require 'rubygems'

  # so I can use yaml (syntax: y object) for sane object printing:
  require 'yaml'

  # http://github.com/michaeldv/awesome_print
  #
  begin
    require 'ap'
  rescue LoadError
    puts "Gem awesome_print not installed. Do you need to add it to Bundler?"
  end


  # http://toolmantim.com/thoughts/system_wide_script_console_logging
  #
  script_console_running = ENV.include?('RAILS_ENV') && IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers')
  rails_running = ENV.include?('RAILS_ENV') && !(IRB.conf[:LOAD_MODULES] && IRB.conf[:LOAD_MODULES].include?('console_with_helpers'))
  irb_standalone_running = !script_console_running && !rails_running

  if script_console_running
    require 'logger'
    Object.const_set(:RAILS_DEFAULT_LOGGER, Logger.new(STDOUT))
  end

  # http://github.com/cldwalker/hirb
  # If you need to disable: Hirb.disable. Remember to limit the columns returned
  # you can always use MyActiveRecord.all(:select => "column_name")
  #
  begin
    require 'hirb' 
    Hirb::View.enable
  rescue LoadError
    puts "Gem hirb not installed. Do you need to add it to Bundler?"
  end

  ETC_IRBRC_LOADED=true
end
