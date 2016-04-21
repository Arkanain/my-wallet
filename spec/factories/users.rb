# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  user_name              :string(255)
#  mobile_number          :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer          default("0")
#  device_id              :string(255)
#  push_token             :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryGirl.define do
  factory :user do |f|
    f.user_name { Faker::Internet.user_name }
    f.mobile_number { Faker::PhoneNumber.cell_phone }
    f.email { Faker::Internet.free_email }
    f.role 0
    f.device_id { Faker::Code.nric }
    f.push_token { Faker::Code.ean }

    factory :admin do |f|
      f.role 1
    end
  end
end
