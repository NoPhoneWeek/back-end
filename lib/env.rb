
module Env
	module_function
	def setup
		ENV['nophone_user'] = 'NOPHONEUSERTABLENAME'
		ENV['nophone_login'] = 'NOPHONELOGINTABLENAME' 
		return true
	end
end