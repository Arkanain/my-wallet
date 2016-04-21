# == Schema Information
#
# Table name: wallets
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :integer
#
# Indexes
#
#  index_wallets_on_place_id  (place_id)
#

class Wallet < ActiveRecord::Base
  has_many :user_wallets, dependent: :destroy
  has_many :users, through: :user_wallets

  belongs_to :place

  attr_accessible :place, :users, :user_wallets
  attr_accessible :title

  validates_presence_of :place, :title
end
