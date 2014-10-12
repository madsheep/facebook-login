
Devise.setup do |config|

  config.secret_key = 'daa8cc14e58eb44d15627459f3fcaf5ceb9f14ea749ef696c23a1ae3ae0bbbb37743376fbebaf24ad683007c2f6c5a3ffa439b37fff0e6f4a98d7142fa2b6a51'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]

  config.strip_whitespace_keys = [ :email ]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true

  config.password_length = 8..128

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  require 'devise/orm/active_record'

  config.omniauth :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"], { :scope => 'email, offline_access' }

end
