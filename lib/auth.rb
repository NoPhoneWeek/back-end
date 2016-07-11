
require_relative 'user_funcs'

module Authorisation
	module_function
  def check(username, password)
    loginid = Login.new.check(username, password)
	profile = UserFuncs.new.find_by_id(loginid)
    return TokenProvider.issue_token(profile)  unless profile.nil? 
  end
end
