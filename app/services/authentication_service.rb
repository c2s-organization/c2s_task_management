class AuthenticationService
  include HTTParty
  base_uri ENV["URL_MS_AUTH"]

  def self.login(email, password)
    post('/login', body: { email: email, password: password }.to_json, headers: { 'Content-Type' => 'application/json' })
  rescue StandardError => e
    Rails.logger.error("Login failed: #{e.message}")
    nil
  end

  def self.register(email, password, password_confirmation)
    post('/register', body: { email: email, password: password, password_confirmation: password_confirmation }.to_json, headers: { 'Content-Type' => 'application/json' })
  rescue StandardError => e
    Rails.logger.error("Registration failed: #{e.message}")
    nil
  end
end
