class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.string  :title

      t.timestamps null: false
    end
  end
end
