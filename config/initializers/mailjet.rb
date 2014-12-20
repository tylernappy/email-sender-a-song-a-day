Mailjet.configure do |config|
  config.api_key = ENV['yourApiKey']
  config.secret_key = ENV['yourSecretKey']
  config.default_from = ENV['myRegisteredMailjetEmailAtDomainDotCom']
end
