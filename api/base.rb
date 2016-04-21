module Api
  class Base < Grape::API
    helpers Api::Helpers

    prefix 'api'
    default_format :json
    format :json

    # Using param means that we will include version of api into path after prefix
    # Example below will create route like 'api/v1':
    # version 'v1', using: :path

    # Endpoints
    mount Api::Endpoint::Device
  end
end