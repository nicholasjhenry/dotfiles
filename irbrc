require 'rubygems'

require 'wirble'
Wirble.init
Wirble.colorize

# http://github.com/michaeldv/awesome_print
require 'ap'

ActiveRecord::Base.logger = Logger.new(STDOUT)