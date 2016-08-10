class AddIpAddressToOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :pay_type
    add_column :orders, :ip_address, :string
    add_column :orders, :card_type, :string
    add_column :orders, :card_expires_on, :date
    add_reference :orders, :cart, foreign_key: true
    add_reference :orders, :user, foreign_key: true
  end
end
