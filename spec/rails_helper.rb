require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

# Limpar o banco de dados entre os testes
require 'database_cleaner-active_record'

# Requer os arquivos de suporte, como helpers, se houver
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Configurar o DatabaseCleaner
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Incluir o FactoryBot para facilitar a criação de objetos
  config.include FactoryBot::Syntax::Methods

  # Configurações padrão para o RSpec Rails
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  # Filtrar testes pendentes e falhos
  config.filter_rails_from_backtrace!
end
