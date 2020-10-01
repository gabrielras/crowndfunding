require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {

    # Configuration for Amazon S3
    :provider              => 'AWS',
    :aws_access_key_id     => ENV["AWS_KEY_ID"],
    :aws_secret_access_key => ENV["AWS_SECRET_KEY"],
    :region                => 'us-east-1'
  }

  config.storage = :fog

  config.fog_directory = ENV["AWS_FOG_DIRECTORY"]
  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
end
