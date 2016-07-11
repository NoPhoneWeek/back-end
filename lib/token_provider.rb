require 'jwt'
#The TokenProvider is a generic service that is going to be responsible for validating and creating tokens that we'll use #for users of our application, by using the jwt library that we added as a dependency. For the dynamic part of the token, #we're going to keep it simple and use the Rails' application secret itself


module TokenProvider
  module_function
    def issue_token(payload)
      JWT.encode(payload, ENV['nophone_secret'])
    end
    def valid?(token)
        begin
          JWT.decode(token, ENV['nophone_secret'])
        end
      end
end