require "sinatra/base"
require "oj"
Oj.default_options = {:mode => :compat}

require_relative "../lib/user_login.rb"

module NoPhoneWeek
    class LoginRoutes < Sinatra::Base
        @@user_login = Login.new()
        get "/loginform" do
            content_type "text/html"
            return "THIS IS TEMPORARY!!! Besides, it does not use the auth class<br><form action='/login' method='post'>Name:<br><input type='text' name='username'><br>Pass:<br><input type='text' name='password'><br><br><input type='submit' value='Submit'>"
        end
        
        post "/login" do
          username, password = params[:username], params[:password]
          id = @@user_login.check(username, password)
          if id.nil?
            return Oj.dump({:success => false, :message => "Invalid credentials"})
          else
            return Oj.dump({:success => true, :message => "Successfully logged in!", :id => id})
          end
        end
    end
end

