require "sinatra/base"

require "oj"
Oj.default_options = {:mode => :compat}

require_relative "../lib/auth"

module NoPhoneWeek
  class AuthRoutes < Sinatra::Base
    @@auth_db = Db.new(ENV["nophone_login"])
    @@authorization = Authorization.new(@@auth_db)

    get "/authform" do
      content_type "text/html"
      return "THIS IS FOR TESTING!!!<br>"\
      "<form action='/auth' method='post'>Name:<br>"\
      "<input type='text' name='username'><br>Pass:<br>"\
      "<input type='text' name='password'><br>"\
      "<br><input type='submit' value='Submit'>"
    end

    post "/auth" do
      username, password = params[:username], params[:password]
      token = @@authorization.authenticate(username, password)
      if token.nil?
        return Oj.dump({success: false, message: "Invalid credentials"})
      else
        return Oj.dump({success: true, message: "Authentication successful", token: token})
      end
    end

  end
end

