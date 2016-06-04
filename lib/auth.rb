require_relative 'token_provider'
require_relative 'user_login'

class Authorization
	def initialize(authdb)
		@authdb = authdb
	end
	def authenticate(username, password)
		login = Login.new() #Create a new instance of our login class
		unless login.check(username, password).nil? #unless the username and password combination doesn't exist
			return TokenProvider.issue_token(login.check(username, password)) #return a token with the payload being the user's id
		end
	end
end