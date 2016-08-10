class RemoveCartFromOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :cart_id
  end
end
