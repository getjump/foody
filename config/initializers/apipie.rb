Apipie.configure do |config|
  config.app_name                = "Foody API"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.default_version         = "v1"
  config.app_info["v1"]          = "Here we go, Foody API Documentation"
  config.copyright               = "&copy; 2015 Pavel Savinov"
end
