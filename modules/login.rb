require "sinatra/base"
require "oj"


module NoPhoneWeek
    class Login < Sinatra::Base
        post "/login" do
            p params
            if params[:username] == "Username" and params[:password] == "Password"
                Oj::dump({:success => true, :message => "You're logged in!"})
            else
                Oj::dump({:success => false, :message => "Your username is not 'Username' or your password isn't 'Password'"})
            end
        end
    end
end

