#global config
LATTE = YAML::load(File.open("#{Rails.root}/config/latte.yml"))

#mailer
delivery_method = LATTE["delivery_method"]
ActionMailer::Base.default_url_options = { :host => LATTE["default_url_options"]["host"] }
ActionMailer::Base.delivery_method = delivery_method.to_sym
ActionMailer::Base.smtp_settings = {
  :address => LATTE["smtp_settings"]["address"],
  :port => LATTE["smtp_settings"]["port"],
  :domain => LATTE["smtp_settings"]["domain"],
  :authentication => LATTE["smtp_settings"]["authentication"],
  :user_name => LATTE["smtp_settings"]["user_name"],
  :password => LATTE["smtp_settings"]["password"]
}
end