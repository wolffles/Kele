class Kele
  attr_accessor :username, :password
  #just now realized what this does so im adding a note lol, attribute_accessor allows the class object to read or write to attributes that you set.
  attr_reader :arbitrary
  # this will not allow you to set a new value to it.

  def initialize(username, password, arbitrary)
    @username = username
    @password = password
    @arbitrary = arbitrary
  end

end
