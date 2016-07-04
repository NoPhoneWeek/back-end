require 'rubygems'
require 'bundler/setup'
require "./lib/env"
require "./lib/db"
require "./lib/auth"
require "./lib/user_login"

raise if Env.setup.nil?

x = Authorisation.check("Jimmy", "HelloWorld")
puts x.to_s

puts TokenProvider.valid?(x)