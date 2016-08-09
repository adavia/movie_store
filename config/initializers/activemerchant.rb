if Rails.env == "development"
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device.sync = true
  ActiveMerchant::Billing::Base.mode = :test

  login = "LD0265-26"
  password="Po7OpLhBCs5kFWbs8Ayd3v6qOlKHQ5aS"
elsif Rails.env == "production"
  login = 'LD0265-26'
  password='Po7OpLhBCs5kFWbs8Ayd3v6qOlKHQ5aS'
end
GATEWAY = ActiveMerchant::Billing::FirstdataE4Gateway.new({
  login: login,
  password: password
})
