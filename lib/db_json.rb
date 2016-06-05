require 'oj'

module DbJson
	def write_to_db(table)
		write_db_file unless File.exists? @file_location
		out_file = File.open(@file_location, "w+")
		out_file.puts(Oj.dump(table, mode: :compat))
		out_file.close()
		true
	end
	def write_db_file
		if File.exists?(@file_location)
			raise
		else
			Dir.mkdir(@file_folder) unless File.exists?(@file_folder)
			File.new(@file_location ,"w")
		end
	end
	def write_row_to_db(row, id = nil)
		if File.exists?(@file_location)
			table = load_all_from_db
			if id.nil?
				row["id"] = table.size 
			else 
				row["id"] = id
			end
			table.push(row)
		else
			if id.nil?
				row["id"] = 0
			else row["id"] = id
			end     
			table = Array.new([row])
		end
    if write_to_db(table)
			return row["id"]
    else
      raise
    end
  end
	def load_all_from_db    
		if File.exists?(@file_location)
			if File.open(@file_location, "r").read.nil? || File.open(@file_location, "r").read.empty? then raise else textm = Oj.load(File.open(@file_location, "r").read)
			end
    else
			raise
		end
	end
	def load_all_from_db_by_var(var, value)
		load_all_from_db.each.select {|entry| entry[var] == value } # Gets all rows that have var match the value passed
  end
	def load_row_from_db(id)
		load_all_from_db_by_var("id", id)
	end
	def load_row_from_db_by_var(var, value)
		load_all_from_db_by_var(var, value)[0]
	end
	def remove_row_from_db(row)
		remove_row_from_db_by_id(row["id"])
	end
	def remove_row_from_db_by_id(id)
		write_to_db(load_all_from_db.reject{|x| x["id"] == id})
	end
end