require 'oj'

class Db
	def initialize(table)
		@tablename = table
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
            
	def Store(object)
		file_location = self.file_location
		if File.exists?(self.file_location)
			textm = self.Load()
            textm.push(object)
		else
			textm = Array.new([object])
		end
		if(self.Update(textm))
			self.activeid = textm.size - 1
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
    
    def LoadById(userid)
        self.activeid = userid
        data = self.Load()
        return data[userid]
    end
    
    def Delete(user)
        data = self.Load()
        data.delete(user)
        self.Update(data)
        return true
    end
end