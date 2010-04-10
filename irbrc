unless defined? ETC_IRBRC_LOADED

  require 'rubygems'

  # so I can use yaml (syntax: y object) for sane object printing:
  require 'yaml'

  # http://pablotron.org/software/wirble/README
  #
  require 'wirble'
  Wirble.init
  Wirble.colorize

  colors = Wirble::Colorize.colors.merge({
    # delimiter colors
    :comma              => :white,
    :refers             => :white,

    # container colors (hash and array)
    :open_hash          => :white,
    :close_hash         => :white,
    :open_array         => :white,
    :close_array        => :white,

    # object colors
    :open_object        => :cyan,
    :object_class       => :purple,
    :object_addr_prefix => :cyan,
    :object_addr        => :light_red,
    :object_line_prefix => :cyan,
    :object_line        => :yellow,
    :close_object       => :cyan,

    # symbol colors
    :symbol             => :blue,
    :symbol_prefix      => :blue,

    # string colors
    :open_string        => :green,
    :string             => :green,
    :close_string       => :green,

    # misc colors
    :number             => :blue,
    :keyword            => :blue,
    :class              => :purple,
    :range              => :white
  })                                     
  Wirble::Colorize.colors = colors                                              
  Wirble.colorize

  # colorize prompt
  IRB.conf[:PROMPT][:CUSTOM] = {
    :PROMPT_I =>    Wirble::Colorize.colorize_string(">> ", :cyan),
    :PROMPT_S =>    Wirble::Colorize.colorize_string(">> ", :green),
    :PROMPT_C => "#{Wirble::Colorize.colorize_string('..' , :cyan)} ",
    :PROMPT_N => "#{Wirble::Colorize.colorize_string('..' , :cyan)} ",
    :RETURN   => "#{Wirble::Colorize.colorize_string('→'  , :light_red)} %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :CUSTOM

  # http://github.com/michaeldv/awesome_print
  #
  require 'ap'

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
  require 'hirb' 
  Hirb::View.enable
   
  ETC_IRBRC_LOADED=true  
end
