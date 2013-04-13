require 'cinch'
require './mms_bot'
require 'pony'
require './mailer'

bot = Cinch::Bot.new do

  mmsb = MMSBot.new
  
  configure do |c|
    c.server   = mmsb.server #"irc.freenode.org"
    c.nick     = mmsb.nick   #"mms_forwarder"
    c.channels = mmsb.channels
  end
  
  #whenever my name is in the channel I want to get a text message with the body of the text message
  on :message, /^byllc/ do |m|
    puts "#{m.inspect} #{m.user.nick}"
  end

  on :message, /^mms on (\d{10})@([\w|.]+)/ do |m,number,carrier|
    nick    = m.user.nick
    mmsb.add_user(nick,number,carrier)
    m.reply "Registered MMS for #{m.user.nick} "
  end

  on :message, /^mms off/ do |m|
    mmsb.remove_user(m.user.nick)
  end

  on :message, /^mms list/ do |m|
    m.reply "Active Users #{mmsb.active_users.keys.join(", ")}"
  end

  on :message, /^mms details/ do |m|
    deets = mmsb.user_details(m.user.nick)
    m.reply "Your mms address is #{deets.number}@#{deets.carrier}"
  end

  on :message, /^(\w+_*:*)\s(.+)/ do |m,prefix,message|
    #is the first word on the line a name in the active list
    if mmsb.active?(prefix)
      send_to      = mmsb.user_address(prefix)
      m = Mailer.new(send_to,m.user.nick,message)
      m.mail
    end
  end
end


bot.start
