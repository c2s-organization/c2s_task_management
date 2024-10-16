# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.to_s + '/swagger'

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          TaskUpdate: {
            type: :object,
            properties: {
              status: { type: :string },
              scraped_data: { type: :string }
            },
            required: ['status']
          },
          Task: {
            type: :object,
            properties: {
              id: { type: :integer },
              status: { type: :string },
              description: { type: :string }
            }
          }
        }
      }
    }
  }

  config.swagger_format = :yaml
end
