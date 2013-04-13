class MMSBot 

  MMSDetails = Struct.new(:nick,:number,:carrier,:active)
  DEFAULT_CONFIG_FILE = "./config/config.yml"

  def initialize
  	@users = {} 
  	load_config_file
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

  def load_config_file
  	@config_file = YAML.load(File.open(DEFAULT_CONFIG_FILE))
  end

  def load_default_users
  	if @config_file['users']
	   user_hash = @config_file['users']
	   user_hash.each_pair do |nick,deets|
	     add_user(nick,deets['number'],deets['carrier'])
	   end
	end
  end

  def nick
    @config_file['nick']
  end

  def channels
    @config_file['channels']
  end

  def server
  	@config_file['server']
  end

end