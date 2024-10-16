class AuthenticationService
  include HTTParty
  base_uri 'http://localhost:3001'

  def self.login(email, password)
    post('/login', body: { email: email, password: password }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def self.register(email, password, password_confirmation)
    post('/register', body: { email: email, password: password, password_confirmation: password_confirmation }.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
