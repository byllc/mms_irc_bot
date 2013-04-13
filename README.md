**A IRC Bot to forward messages to MMS

*Why?
  Because as a team lead I am not always in front of my computer but we use IRC as our centralized method of communication. 
  This lets me know that someone is trying to ping me. 
  
*How?
  Add your configuration details to smtp.yml
  Add your channels list and any default users to config.yml
  Run ircbot.rb
  
  In an IRC channel that contains the bot:
  mms on 8888888@carrier.domain.tld    - register with the server if you are not in the default users list
  mms list                             - list all active users
  mms off                              - deactivate your nick 
  mms details                          - return your mms details
  
  After registration any message that starts with your registered nick will have a text message sent to your credentials

*requirements
  https://github.com/cinchrb/cinch
  https://github.com/benprew/pony
  
*Notes
  Currently only tested with google smtp
  I will gemify if anyone else thinks they would find this useful but I didn't think there was enough here to warrant it
  
