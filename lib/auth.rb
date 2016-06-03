require "digest"

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

class Auth
    def initialize(logindb)
        @logindb = logindb
    end

    # Check(username, password) returns ther user's ID if the username and the password match, nil otherwise
    def Check(username, password)
        table = @logindb.Load() # Load the table. We really need something that does this and the next line in one and more efficiently
        usernameID = table.each_index.select {|id| table[id][:username] == username } # should be a length=1 array
        entry = table[usernameID[0]]    # Get the actual entry
        correct = entry[:processed]     # the correct salted + hashed password
        salt = entry[:salt]             # the salt
        input = Digest::SHA256.hexdigest(password+salt) # the processed password the user is using
        
        if input == correct
            return usernameID[0]        # the user ID
        end
    end
end

