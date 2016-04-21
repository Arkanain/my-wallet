class AddPlaceRefToWallets < ActiveRecord::Migration
  def change
    add_reference :wallets, :place, index: true, foreign_key: true
  end
end
