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

FactoryGirl.define do
  factory :wallet do |f|
    f.title { Faker::Commerce.product_name }
  end
end
