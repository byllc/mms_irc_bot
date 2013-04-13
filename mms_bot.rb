class MMSBot 

  MMSDetails = Struct.new(:nick,:number,:carrier,:active)
  DEFAULT_USER_FILE = "./config/users.yml"

  def initialize
  	@users = {} 
  	load_default_users
  end

  def active?(nick)
    @users.select{|k,v| k == parsed_nick(nick) }.any?
  end

  def add_user(nick,number,carrier)
    @users[parsed_nick(nick)] = MMSDetails.new(nick,number,carrier,true)
  end

  def remove_user(mms_user)
    @users[parsed_nick(nick)].active = false
  end

  def active_users
    @users.select{ |nick,deets| deets.active }
  end
  
  #strip trailing underscores
  def parsed_nick(nick)
    nick.gsub(/_*:*$/,"")
  end

  def user_details(nick)
    @users[parsed_nick(nick)]
  end

  def user_address(nick)
     u = @users[parsed_nick(nick)]
     "#{u.number}@#{u.carrier}"
  end

  def load_default_users
  	if File.exists?(DEFAULT_USER_FILE)
	   user_hash = YAML.load(File.open(DEFAULT_USER_FILE))['users']
	   user_hash.each_pair do |nick,deets|
	     add_user(nick,deets['number'],deets['carrier'])
	   end
	end
  end

end