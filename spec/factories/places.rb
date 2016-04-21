# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  cover_image :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
# Indexes
#
#  index_places_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :place do |f|
    f.name { Faker::Company.name }
    f.cover_image { Faker::Avatar.image }
  end
end
