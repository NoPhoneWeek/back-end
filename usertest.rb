require './lib/user_funcs.rb'
require "./lib/env"

raise if Env.setup.nil?
UserHelper = UserFuncs.new()

newUser = {
    name: 'Joe Bloggs',
    username: 'jbloggs19',
    location: { },
    traveltime: '20 minutes',
    participating: true
}

UserHelper.create(newUser)
UserHelper.create(newUser)
UserHelper.create(newUser)
UserHelper.create(newUser)
UserHelper.create(newUser)
UserHelper.create(newUser)
UserHelper.create(newUser)

puts "This is just kinda here"

temp0 = UserHelper.load_all()
temp = UserHelper.find_by_id()

puts temp.to_s
temparray = []
temp.each do |x|
	x.each do |y|
		temparray.push(y)
	end
end
puts temparray.to_s
puts "--------------------------------------------------"
temp1 = UserHelper.load_all()
temp1.each {|x| }
puts temparray.to_s