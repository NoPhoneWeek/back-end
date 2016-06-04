require 'oj'

class Db
    attr_accessor  :active_id
    attr_reader :table_name
    attr_reader :file_location
    
	def initialize(table, fl = '')
      @table_name = table
      @file_location = fl unless fl.empty? || fl.nil?
      @file_location = "data/#{@table_name}.json"
	end

   
    
    def update(table)
      create() unless File.exists? @file_location
      m = Oj.dump(table, mode: :compat)
      out_file = File.open(self.file_location, "w+")
      out_file.puts(m)
      out_file.close()
      true
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
      if File.exists? @file_location
        textm = load()
          if id.nil? then object[:id] = textm.size else object[:id] = id end  
          textm.push(object)
      else
        if id.nil? then object[:id] = 0 else object[:id] = id end       
        textm = Array.new([object])
      end
      if update(textm)
        @active_id = object[:id]
        return true
      else
        raise
      end
	end
	
	def load()
      textm = nil    
      if File.exists?(@file_location)
        existing_data = File.open(self.file_location, "r")
        textl = existing_data.read
        if textl.nil? || textl.empty? then raise else textm = Oj.load(textl) end 
      end
      textm     
	end
    
	def get_id_by_var(var, value)
      begin
        x = self.load_single_by_var(var, value)
        raise if x[:id].nil? 
        @active_id = x[:id]
        true
      rescue => exception
        false
      end
	end
	
    def load_by_id(userid)
      load_single_by_var(:id, userid)
    end
	
	def load_by_var(var, value)
      data = load() #loads table from DB
      results = data.each.select {|entry| entry[var] == value } # Gets all rows that have var match the value passed
	end
	
	def load_single_by_var(var, value)
      x = load_by_var(var, value) #Uses the above function and returns the first entry
      x[0]
	end
		
    
    def delete(user)
      data = load()
      data.delete(user)
      update(data)
      true
    end
end