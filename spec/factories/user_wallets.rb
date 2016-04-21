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

FactoryGirl.define do
  factory :user_wallet do |f|
    f.serial_number { Faker::Company.swedish_organisation_number }
  end
end
