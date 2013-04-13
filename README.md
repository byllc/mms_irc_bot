## A IRC Bot to forward messages to MMS
  This is a very simple wrapper around Pony and Cinch. As it was just quickly abstracted from a one off script it still 
  needs some tests but the base functionality works. 
  
# Why?
  Because as a team lead I am not always in front of my computer but we use IRC as our centralized method of communication. 
  This lets me know that someone is trying to ping me. 
  
# How?
  1. Add your configuration details to smtp.yml
  2. Add your channels list and any default users to config.yml
  3. Run ircbot.rb
  
  4. In an IRC channel that contains the bot:
    * mms on 8888888@carrier.domain.tld    - register with the server if you are not in the default users list
    * mms list                             - list all active users
    * mms off                              - deactivate your nick 
    * mms details                          - return your mms details
  
  After registration any message that starts with your registered nick will have a text message sent to your credentials

# Requirements
  - https://github.com/cinchrb/cinch
  - https://github.com/benprew/pony
  
# Notes
  Currently only tested with google smtp

  I will gemify if anyone else thinks they would find this useful but I didn't think there was enough here to warrant it
  
  This was really just a one off script that I started cleaning up, I need to add some tests 
  
