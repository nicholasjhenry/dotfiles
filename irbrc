require 'rubygems'

require 'wirble'
Wirble.init
Wirble.colorize

require 'hirb'
Hirb::View.enable
Hirb::View.formatter_config
extend Hirb::Console

# ActiveRecord::Base.logger = Logger.new(STDOUT)