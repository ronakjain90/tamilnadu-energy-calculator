set :stage, :production

server ENV['IESS_STAGING_ENDPOINT'], user: 'root', roles: %w{app db web}