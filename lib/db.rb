<<<<<<< HEAD
require_relative 'db_redis'
=======
require_relative 'db_json'
>>>>>>> refs/remotes/origin/dev

class Db
	def initialize(table)
		@table_name = table
<<<<<<< HEAD
		@redis = Redis.new
		# @file_folder = "data"
		# @file_location = "#{@file_folder}/#{@table_name}.json"
      @file_location = "data/#{@table_name}.json"
    def update(table)
      create() unless File.exists? @file_location
      m = Oj.dump(table, mode: :compat)
	end
	prepend DbRedis
=======
		@file_folder = "data"
		@file_location = "#{@file_folder}/#{@table_name}.json"
	end
	prepend DbJson
>>>>>>> refs/remotes/origin/dev
	def update(table)
		write_to_db(table)
	end
	def create
		write_db_file
	end            
	def store(object, id = nil)
		write_row_to_db(object)   
	end	
	def load
		load_all_from_db || {}
	end  
	def get_id_by_var(var, value)
      load_single_by_var(var, value)["id"]
	end
	def load_by_id(id)
		load_single_by_var("id", id)
  end
	def load_by_var(var, value)
		load_all_from_db_by_var(var, value)
	end
	def load_single_by_var(var, value)
		load_row_from_db_by_var(var, value)
	end
	def delete(object)
		remove_row_from_db(object)
	end
	def delete_by_id(id)
		remove_row_from_db_by_id(id)
	end
end
