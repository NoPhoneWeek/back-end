require_relative 'token_provider'
require_relative 'user_login'

class Authorization
    
  def initialize(auth_db)
    @auth_db = auth_db
  end
    
  def authenticate(username, password)
    login = Login.new() #Create a new instance of our login class
    return TokenProvider.issue_token(login.check(username, password))  unless login.check(username, password).nil? 
  end
end
