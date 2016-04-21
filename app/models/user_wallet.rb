# == Schema Information
#
# Table name: user_wallets
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  wallet_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  serial_number :string(255)
#

class UserWallet < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :wallet

  attr_accessible :user, :wallet
  attr_accessible :serial_number

  validates_presence_of :serial_number, :user_id, :wallet
end
