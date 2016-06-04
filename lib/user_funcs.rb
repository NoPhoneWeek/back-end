require_relative 'db'


=begin
	An example of the user model.
{
    name: 'Joe Bloggs',
    username: 'jbloggs19',
    location: { },
    traveltime: '20 minutes',
    participating: true
}
=end
	

class UserFuncs
  def initialize(datab = nil)
    if datab.nil? then @datab = Db.new(ENV['nophone_user']) else @datab = datab end
  end
	
  def create(user)
    test_id = nil
    test_id = @datab.active_id if @datab.store(user)
    test_id
  end
	
  def delete(user)
    return @datab.delete(user)
  end
	
  def find_by_id(userid)
    return @datab.load_by_id(userid)
  end

  def load_all
    return @datab.load()
  end
end

