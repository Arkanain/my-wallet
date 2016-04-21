class AddSerialNumberToUserWallets < ActiveRecord::Migration
  def change
    add_column :user_wallets, :serial_number, :string
  end
end
