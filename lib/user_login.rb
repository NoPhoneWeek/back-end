require "digest"
require_relative "db"

=begin

    As I have it right now, the entries in the login table are like this one:
    
    {
        username: "Jimmy",
        salt: "a0y08jRVo1kqgsIsW5XVNw==",
        processed: "66c7fb92bad0b5955a946ba2c56fc09b561feabaa77e6bec10adb499ac19aee6"
    }

    The salt can be anything, really. I just used b64 to test it. Just remember to have them be unique to each entry. Longer salts reduce the effectiveness of rainbow tables. 
    The :processed value is the hexadecimal SHA256 hash for the password+salt.

=end

class Login
    
  def initialize(login_db = nil)
    if login_db.nil? then @login_db = Db.new(ENV['nophone_login']) else @login_db = login_db end      
  end

    # Check(username, password) returns ther user's ID if the username and the password match, nil otherwise
    def check(username, password)
      user_login_details = @login_db.load_single_by_var("username", username)
      return nil if user_login_details.nil?
      correct, salt = user_login_details["processed"], user_login_details["salt"]      # the correct salted + hashed password and salt
      input = Digest::SHA256.hexdigest("#{password}#{salt}") # the processed password the user is using
      return user_login_details["id"] if input == correct
    end
end

