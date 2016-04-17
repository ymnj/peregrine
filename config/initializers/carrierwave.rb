CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     Rails.application.secrets.AWS_ACCESS_KEY_ID || ENV["AWS_ACCESS_KEY_ID"],                        # required
    aws_secret_access_key: Rails.application.secrets.AWS_SECRET_ACCESS_KEY || ENV["AWS_SECRET_ACCESS_KEY"],                        # required
    region:                'US Standard'                 # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = "peregrine-app"                          # required
  config.fog_public     = false
end