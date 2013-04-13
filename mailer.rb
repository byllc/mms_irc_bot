require 'pony'

class Mailer

  SMTP_OPTIONS        = './config/smtp.yml'
  DEFAULT_ENVIRONMENT = 'development'

  def initialize(to,subj,body)
    @env     = ENV['IRCBOT_ENV'] || DEFAULT_ENVIRONMENT
    @to      = to
    @subject = subj
    @body    = body

    load_smtp_options
  end

  def mail
      Pony.mail({
        :to      => @to      ,
        :from    => @from    ,
        :subject => @subject ,
        :body    => @body    ,
        :via     => :smtp    ,
        :via_options => symbolize_keys(@smtp_options)
      })
  end

  def load_smtp_options
    @smtp_options ||= YAML.load(File.open(SMTP_OPTIONS))[@env]
    @from         ||= @smtp_options.delete('from')
  end 

  #the mail configuration for pony appears to be expecting symbolized hash keys
  def symbolize_keys(hash)
    symbolized = {}
    hash.keys.each {|k| symbolized[k.to_sym] = hash.delete(k)} 
    symbolized
  end

end

