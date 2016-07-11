=begin
    Yes, I know this is some horrible test code :/
=end
require 'rubygems'
require 'bundler/setup'
require "digest"
require_relative "../lib/db"
require_relative "../lib/user_login"
require "securerandom"

saltlen = 16 # JUST FOR READABILITY; NEVER USE A SALT LENGTH LESS THAN 512

pass1 = "HelloWorld"
salt1 = SecureRandom.base64(saltlen)

pass2 = "correcthorsebatterystaple"
salt2 = SecureRandom.base64(saltlen)

pass3 = "L3Tm31n"
salt3 = SecureRandom.base64(saltlen)

pass4 = "h4xx0rz"
salt4 = SecureRandom.base64(saltlen)

pass5 = "HelloThere"
salt5 = SecureRandom.base64(saltlen)

pass6 = "IRanOutOfPasswordIdeasHelpMe"
salt6 = SecureRandom.base64(saltlen)

logindb = Db.new("LOGIN")
login = Login.new(logindb)

logindb.update([])  # Reset the table
logindb.store({username: "Jimmy",   salt: salt1, processed: Digest::SHA256.hexdigest(pass1+salt1)})
logindb.store({username: "Johnny",  salt: salt2, processed: Digest::SHA256.hexdigest(pass2+salt2)})
logindb.store({username: "Somebody",salt: salt3, processed: Digest::SHA256.hexdigest(pass3+salt3)})
logindb.store({username: "Make",    salt: salt4, processed: Digest::SHA256.hexdigest(pass4+salt4)})
logindb.store({username: "A",       salt: salt5, processed: Digest::SHA256.hexdigest(pass5+salt5)})
logindb.store({username: "Sandwich",salt: salt6, processed: Digest::SHA256.hexdigest(pass6+salt6)})

while true
    puts "Username:"
    uname = gets.chomp
    puts "Pass:"
    pass = gets.chomp

    id = login.check(uname, pass)
    if id == nil
        p "Login failed!"
    else
        p "Yay! ID: "+id.to_s
    end
end

