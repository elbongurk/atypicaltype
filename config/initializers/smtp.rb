if Rails.env.staging? || Rails.env.production?
  SMTP_SETTINGS = {
    address: ENV['SMTP_ADDRESS'], # example: 'smtp.service.com'
    domain: ENV['SMTP_DOMAIN'], # example: 'this-app.com'
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: :login,
    enable_starttls_auto: true
  }
end
