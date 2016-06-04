require_relative 'token_provider'
require_relative 'user_login'

class Authorization
  @@login = Login.new()

  def initialize(auth_db)
    @auth_db = auth_db
  end
    
  def authenticate(username, password)
    id = @@login.check(username, password)
    return TokenProvider.issue_token({:id => id})  unless id.nil? 
  end
end

