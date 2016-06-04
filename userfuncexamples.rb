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
temp = UserHelper.find_by_id(4)

puts temp.to_s

UserHelper.delete(temp)
puts "--------------------------------------------------"
temp1 = UserHelper.load_all()

puts temp1.to_s