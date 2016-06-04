require "sinatra/base"
require "oj"


module NoPhoneWeek
    class Login < Sinatra::Base
        get "/login" do
            content_type "text/html"
            return "<form action='/login' method='post'>Name:<br><input type='text' name='username'><br>Pass:<br><input type='text' name='password'><br><br><input type='submit' value='Submit'>"
        end
        
        post "/login" do
            if params[:username] == "Username" and params[:password] == "Password"
                Oj::dump({:success => true, :message => "You're logged in!"})
            else
                Oj::dump({:success => false, :message => "Your username is not 'Username' or your password isn't 'Password'"})
            end
        end
    end
end

