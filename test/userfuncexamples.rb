require '../lib/user_funcs.rb'

UserHelper = UserFuncs.new()

newUser = {
    name: 'Joe Bloggs',
    username: 'jbloggs19',
    location: { },
    traveltime: '20 minutes',
    participating: true
}

UserHelper.Create(newUser)
UserHelper.Create(newUser)
UserHelper.Create(newUser)
UserHelper.Create(newUser)
UserHelper.Create(newUser)
UserHelper.Create(newUser)
UserHelper.Create(newUser)

puts "This is just kinda here"

temp0 = UserHelper.LoadAll()
temp = UserHelper.FindById(0)

temp2 = UserHelper.Delete(newUser)

temp3 = UserHelper.LoadAll()
