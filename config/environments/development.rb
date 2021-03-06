Pyc::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.

  config.paperclip_defaults = {
    storage: :dropbox,
    dropbox_credentials: {
      app_key: ENV["DROPBOX_APP_KEY"],
      app_secret: ENV["DROPBOX_APP_SECRET"],
      access_token: ENV["DROPBOX_ACCESS_TOKEN"],
      access_token_secret: ENV["DROPBOX_ACCESS_TOKEN_SECRET"],
      user_id: ENV["DROPBOX_USER_ID"],
      access_type: "app_folder"
    },
    dropbox_visibility: 'public',
    dropbox_options: {}
  }

  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.action_mailer.smtp_settings = {
    address: "smtp.sendgrid.net",
    port: 587,
    domain: ENV["DOMAIN_NAME"],
    authentication: "plain",
    user_name: ENV["SENDGRID_USERNAME"],
    password: ENV["SENDGRID_PASSWORD"]
  }
  # ActionMailer Config
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  # Send email in development mode?
  config.action_mailer.perform_deliveries = true

end
