require 'securerandom'

module Env
  module_function
    def setup
     ENV['nophone_user'] = 'NOPHONEUSERTABLENAME'
     ENV['nophone_login'] = 'NOPHONELOGINTABLENAME' 
     ENV['nophone_secret'] = SecureRandom.base64()
     return true
  end
end
