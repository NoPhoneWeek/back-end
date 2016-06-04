
module Env
	module_function
	def setup
		ENV['nophone_user'] = 'NOPHONEUSERTABLENAME'
		ENV['nophone_login'] = 'NOPHONELOGINTABLENAME'
		ENV['nophone_secret'] = 'SUPERSECRETSECRET'
		return true
	end
end