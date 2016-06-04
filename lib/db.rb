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
    
    def update(table)
        unless File.exists?(self.file_location)
			self.create()
        end
		m = Oj.dump(table, mode: :compat)
        out_file = File.open(self.file_location, "w+")
        out_file.puts(m)
        out_file.close()
        return true
    end
	
	def create()
		if File.exists?(self.file_location)
			raise
		else
			Dir.mkdir('data') unless File.exists?('data')
			File.new(file_location ,"w")
		end
	end
            
	def store(object, id = nil)
		if File.exists?(self.file_location)
			textm = self.load()
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
		if(self.update(textm))
			self.activeid = object[:id]
			return true
		else
			raise
		end
	end
	
	def load()
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
    
	def getidbyvar(var, value)
		begin
			x = self.loadsinglebyvar(var, value)
			x[:id].nil? raise
			self.activeid = x[:id]
			return true
		rescue => exception
			return false
		end
	end
	
    def loadById(userid)
        return self.loadsinglebyvar(:id, userid)
    end
	
	def loadbyvar(var, value)
		data = self.load() #loads table from DB
		results = data.each.select {|entry| entry[var] == value } # Gets all rows that have var match the value passed
		return results
	end
	
	def loadsinglebyvar(var, value)
		x = self.loadbyvar(var, value) #Uses the above function and returns the first entry
		return x[0]
	end
		
    
    def delete(user)
        data = self.load()
        data.delete(user)
        self.update(data)
        return true
    end
end