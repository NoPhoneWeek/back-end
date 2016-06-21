require 'oj'

class Db
	def initialize(table, fl = '')
		@tablename = table
		unless fl.empty? || fl.nil?
        		@file_location = fl
		end
		@file_location = 'data/' + self.tablename + '.json'
	end

    attr_reader :activeid
    attr_writer :activeid
    attr_reader :tablename
    attr_reader :file_location
    
    def Update(table)
        unless File.exists?(self.file_location)
			self.Create()
        end
		m = Oj.dump(table)
        out_file = File.open(self.file_location, "w+")
        out_file.puts(m)
        out_file.close()
        return true
    end
	
	def Create()
		if File.exists?(self.file_location)
			raise
		else
			Dir.mkdir('data') unless File.exists?('data')
			File.new(file_location ,"w")
		end
	end
            
	def Store(object, id = nil)
		if File.exists?(self.file_location)
			textm = self.Load()
			if id.nil?
				object[:id] = textm.size
			else
				object[:id] = id
			end
            textm.push(object)
		else
			if id.nil?
				object[:id] = 0
			else
				object[:id] = id
			end
			textm = Array.new([object])
		end
		if(self.Update(textm))
			self.activeid = object[:id]
			return true
		else
			raise
		end
	end
	
	def Load()
		if File.exists?(self.file_location)
			existingdata = File.open(self.file_location, "r")
			textl = existingdata.read
            if textl.nil? || textl.empty? then raise
            else
                textm = Oj.load(textl)
                return textm
            end
		else
			return nil
		end
	end
    
	def GetIdByVar(var, value)
		begin
			x = self.LoadSingleByVar(var, value)
			x[:id].nil? raise
			self.activeid = x[:id]
			return true
		rescue => exception
			return false
		end
	end
	
    def LoadById(userid)
        return self.LoadSingleByVar(:id, userid)
    end
	
	def LoadByVar(var, value)
		data = self.Load() #Loads table from DB
		results = data.each.select {|entry| entry[var] == value } # Gets all rows that have var match the value passed
		return results
	end
	
	def LoadSingleByVar(var, value)
		x = self.LoadByVar(var, value) #Uses the above function and returns the first entry
		return x[0]
	end
		
    
    def Delete(user)
        data = self.Load()
        data.delete(user)
        self.Update(data)
        return true
    end
end
