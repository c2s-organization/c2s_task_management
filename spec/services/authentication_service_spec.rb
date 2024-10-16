# spec/services/authentication_service_spec.rb
require 'rails_helper'

RSpec.describe AuthenticationService, type: :service do
  describe '.login' do
    let(:email) { 'test@example.com' }
    let(:password) { 'password123' }
    let(:login_url) { 'http://localhost:3001/login' }

    context 'when the credentials are valid' do
      let(:token) { 'dummy_jwt_token' }
      let(:response_body) { { token: token }.to_json }

      before do
        stub_request(:post, login_url)
          .with(
            body: { email: email, password: password }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns a successful response with the token' do
        response = AuthenticationService.login(email, password)
        expect(response.success?).to be(true)
        expect(response['token']).to eq(token)
      end

      it 'makes a POST request with the correct parameters' do
        AuthenticationService.login(email, password)
        expect(a_request(:post, login_url)
                 .with(
                   body: { email: email, password: password }.to_json,
                   headers: { 'Content-Type' => 'application/json' }
                 )).to have_been_made.once
      end
    end

    context 'when the credentials are invalid' do
      let(:response_body) { { error: 'Invalid credentials' }.to_json }

      before do
        stub_request(:post, login_url)
          .with(
            body: { email: email, password: password }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 401, body: response_body, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns a failed response' do
        response = AuthenticationService.login(email, password)
        expect(response.success?).to be(false)
        expect(response['error']).to eq('Invalid credentials')
      end

      it 'makes a POST request with the correct parameters' do
        AuthenticationService.login(email, password)
        expect(a_request(:post, login_url)
                 .with(
                   body: { email: email, password: password }.to_json,
                   headers: { 'Content-Type' => 'application/json' }
                 )).to have_been_made.once
      end
    end

    context 'when an exception occurs during the request' do
      before do
        allow(AuthenticationService).to receive(:post).and_raise(StandardError.new('Network Error'))
      end

      it 'returns nil and logs the error' do
        expect(Rails.logger).to receive(:error).with('Login failed: Network Error')
        response = AuthenticationService.login(email, password)
        expect(response).to be_nil
      end
    end
  end

  describe '.register' do
    let(:email) { 'newuser@example.com' }
    let(:password) { 'password123' }
    let(:password_confirmation) { 'password123' }
    let(:register_url) { 'http://localhost:3001/register' }

    context 'when the registration details are valid' do
      let(:response_body) { { message: 'Registration successful' }.to_json }

      before do
        stub_request(:post, register_url)
          .with(
            body: { email: email, password: password, password_confirmation: password_confirmation }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 201, body: response_body, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns a successful response with the message' do
        response = AuthenticationService.register(email, password, password_confirmation)
        expect(response.success?).to be(true)
        expect(response['message']).to eq('Registration successful')
      end

      it 'makes a POST request with the correct parameters' do
        AuthenticationService.register(email, password, password_confirmation)
        expect(a_request(:post, register_url)
                 .with(
                   body: { email: email, password: password, password_confirmation: password_confirmation }.to_json,
                   headers: { 'Content-Type' => 'application/json' }
                 )).to have_been_made.once
      end
    end

    context 'when the registration details are invalid' do
      let(:response_body) { { error: 'Registration failed' }.to_json }

      before do
        stub_request(:post, register_url)
          .with(
            body: { email: email, password: password, password_confirmation: password_confirmation }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
          .to_return(status: 422, body: response_body, headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns a failed response' do
        response = AuthenticationService.register(email, password, password_confirmation)
        expect(response.success?).to be(false)
        expect(response['error']).to eq('Registration failed')
      end

      it 'makes a POST request with the correct parameters' do
        AuthenticationService.register(email, password, password_confirmation)
        expect(a_request(:post, register_url)
                 .with(
                   body: { email: email, password: password, password_confirmation: password_confirmation }.to_json,
                   headers: { 'Content-Type' => 'application/json' }
                 )).to have_been_made.once
      end
    end

    context 'when an exception occurs during the request' do
      before do
        allow(AuthenticationService).to receive(:post).and_raise(StandardError.new('Network Error'))
      end

      it 'returns nil and logs the error' do
        expect(Rails.logger).to receive(:error).with('Registration failed: Network Error')
        response = AuthenticationService.register(email, password, password_confirmation)
        expect(response).to be_nil
      end
    end
  end
end
