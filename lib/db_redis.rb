require "redis"


module DbRedis
	def write_to_db(table)
		table.each{|x| write_row_to_db(x)}
	end
	def write_row_to_db(row, id = nil)
		id = @redis.incr("next_#{@table_name}_id") unless row["id"] != nil
		x = "#{@table_name}:#{id.to_s}"
		temparray = []
		row.each do |x|
			x.each do |y|
				temparray.push(y)
			end
		end
		raise unless(@redis.hmset(x, temparray)) == "OK"
    raise unless(@redis.hset("#{@table_name}s", (row.flatten)[1].to_s, id.to_s)) == false
		raise unless(@redis.lpush("#{@table_name}_ids", id)) != nil
		return id
  end
	def load_all_from_db    
		temparray = []
		idlist = @redis.lrange("#{@table_name}_ids", 0, -1)
		idlist.each {|x| temparray.push(load_row_from_db(x))}
		temparray
	end
	def load_all_from_db_by_var(var, value)
		temp =load_all_from_db
		temp.each.select {|entry| entry[var] == value } # Gets all rows that have var match the value passed
  end
	def load_row_from_db(id)
		@redis.hgetall("#{@table_name}:#{id}").merge({"id"=> id})
	end
	def load_row_from_db_by_var(var, value)
		load_all_from_db_by_var(var, value)[0]
	end
	def remove_row_from_db(row)
		remove_row_from_db_by_id(row["id"])
	end
	def remove_row_from_db_by_id(id)
		@redis.del("#{table}:#{id}")
	end
end