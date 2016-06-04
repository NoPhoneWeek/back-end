require_relative 'db'


=begin
	An example of the user model.
{
    name: 'Joe Bloggs',
    username: 'jbloggs19',
    location: { },
    traveltime: '20 minutes',
    participating: true
}
=end
	

class UserFuncs
	def initialize(datab = nil)
		if datab.nil?
			@datab = Db.new(ENV['nophone_user'])
		else
			@datab = datab
		end
	end
	
	def create(user)
		if(datab.store(user))
			testid = datab.activeid
			return testid
		end
	end
	
	def delete(user)
		if(datab.Delete(user))
			return true
		else
			return false
		end
	end
	
	def findbyid(userid)
		return datab.loadbyid(userid)
	end

	def loadall
		return datab.load()
	end
end