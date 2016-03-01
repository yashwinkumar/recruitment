CarrierWave.configure do |config|
  # config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              "AWS",                        # required
    aws_access_key_id:     ENV["aws_access_key_id"],                        # required
    aws_secret_access_key: ENV["aws_secret_access_key"],                        # required
    region:                'us-east-1',                  # optional, defaults to 'us-east-1'
    # host:                  's3.videoresume.com',             # optional, defaults to nil
    # endpoint:              'http://videoresume.com' # optional, defaults to nil
  }
  config.fog_directory  = ENV["fog_directory"]                         # required
  config.fog_public     = false                                        # optional, defaults to true
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
end