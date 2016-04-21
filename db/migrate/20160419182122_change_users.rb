class ChangeUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :device_id
      t.string :push_token
    end
  end
end
