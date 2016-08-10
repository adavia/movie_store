if Rails.env == "development"
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device = File.open(Rails.root.join("log","active_merchant.log"), "a+")
  ActiveMerchant::Billing::FirstdataE4Gateway.wiredump_device.sync = true
  ActiveMerchant::Billing::Base.mode = :test

  login = "ID7732-67"
  password="Gu8z70SFIi1g5hkFDq3C5YW4ddwEx4w3"
elsif Rails.env == "production"
  login = 'ID7732-67'
  password='Gu8z70SFIi1g5hkFDq3C5YW4ddwEx4w3'
end
GATEWAY = ActiveMerchant::Billing::FirstdataE4Gateway.new({
  login: login,
  password: password
})
