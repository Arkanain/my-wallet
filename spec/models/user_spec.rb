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

require 'rails_helper'

describe User do
  let(:admin) { create(:admin) }
  let(:place) { create(:place) }
  let(:wallet) { create(:wallet, place: place) }
  let(:built_wallet) { build(:user_wallet, wallet: wallet) }

  it 'has valid factory' do
    expect(build(:admin)).to be_valid
  end

  it 'invalid without role' do
    expect(build(:admin, role: nil)).not_to be_valid
  end

  it 'creates without password(with default password of course)' do
    expect(build(:admin)).to be_valid
  end

  it 'creates with password' do
    password = Faker::Internet.password(8)
    new_user = build(:admin, password: password)

    expect(new_user).to be_valid

    new_user.save

    expect(new_user.valid_password?(password)).to be_truthy
  end

  it 'get place via places' do
    admin.places << place

    expect(admin.places).not_to be_empty
    expect(admin.places.count).to eq(1)
    expect(admin.places.first).to eq(place)
  end

  it 'get user_wallets' do
    expect(admin.user_wallets).to be_empty

    admin.user_wallets << built_wallet

    expect(admin.user_wallets).not_to be_empty
    expect(admin.user_wallets.count).to eq(1)
  end

  it 'get wallets via user_wallets' do
    expect(admin.wallets).to be_empty

    admin.user_wallets << built_wallet

    expect(admin.wallets).not_to be_empty
    expect(admin.wallets.count).to eq(1)
    expect(admin.wallets.first).to eq(wallet)
  end
end
