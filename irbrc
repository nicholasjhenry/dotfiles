require 'rubygems'

# http://pablotron.org/software/wirble/README
#
require 'wirble'
Wirble.init
Wirble.colorize

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