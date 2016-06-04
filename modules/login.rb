require "sinatra/base"
require "oj"
Oj.default_options = {:mode => :compat}

require_relative "../lib/user_login.rb"

module NoPhoneWeek
    class LoginRoutes < Sinatra::Base
        @@user_login = Login.new()
        get "/loginform" do
            content_type "text/html"
            return "<code>/loginform</code> and <code>/login</code> aren't used anymore and were only tests. See <code>/auth</code> and <code>/authform</code>"
        end
        
        post "/login" do
          return "{\"success\":false,\"message\":\"The /login call is not used anymore. Use /auth and test it with /authform\"}"
        end
    end
end

