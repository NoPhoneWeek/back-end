require "redis"

redis = Redis.new

puts id = redis.incr("next_test_id")
x = "test"+":"+id.to_s
puts redis.hmset(x, ["username", "Joe", "password", "devpass", "location", {}])
v = redis.hset("tests", "Joe", id.to_s)
puts v
puts redis.lpush("#test_ids", id)
puts redis.lrange("#test_ids", 0, -1)
x = (redis.hgetall("test:26").merge({"id"=> id}))

gets