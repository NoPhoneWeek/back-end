require_relative 'token_provider'
require_relative 'user_login'

class Authorization
  @@login = Login.new() # Don't create a new Login instance everytime you auth somebody; have a static one
    
  def initialize(auth_db)
    @auth_db = auth_db
  end

  def authenticate(username, password)
    id = @@login.check(username, password) # I do this to cut the number of function calls in half
    return TokenProvider.issue_token({:id => id})  unless id.nil? 
  end
end
