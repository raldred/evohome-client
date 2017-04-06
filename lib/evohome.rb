require 'faraday'
require 'faraday_middleware'
require 'json'
require 'addressable/uri'

module Evohome
  autoload :Associations, 'evohome/client'
  autoload :Errors, 'evohome/errors'
  autoload :Middleware, 'evohome/middleware'
  autoload :Connection, 'evohome/connection'
  autoload :Client, 'evohome/client'
  autoload :AccountInfo, 'evohome/account_info'
  autoload :Location, 'evohome/location'
  autoload :VERSION, 'evohome/version'
end