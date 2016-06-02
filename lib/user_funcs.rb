require_relative 'db'

class UserFuncs
    USERTABLENAME = "USERTABLE"
	DataB = Db.new(USERTABLENAME)
	def Create(user)
		if(DataB.Store(user))
			testid = DataB.activeid
			return testid
		end
	end
	
	def Delete(user)
		if(DataB.Delete(user))
			return true
		else
			return false
		end
	end
	
	def FindById(userid)
		return DataB.LoadById(userid)
	end

	def LoadAll
		return DataB.Load()
	end
end