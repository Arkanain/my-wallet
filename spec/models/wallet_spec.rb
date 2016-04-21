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

require 'rails_helper'

describe Wallet do
  let(:admin) { create(:admin) }
  let(:place) { create(:place, user: admin) }
  let(:wallet) { create(:wallet, place: place) }
  let(:built_wallet) { build(:user_wallet, user: admin) }

  it 'has valid fatory' do
    expect(build(:wallet, place: place)).to be_valid
  end

  it 'invalid without place' do
    expect(build(:wallet)).not_to be_valid
  end

  it 'invalid without title' do
    expect(build(:wallet, title: nil, place: place)).not_to be_valid
  end

  it 'valid with place' do
    expect(wallet).to be_valid
  end

  it 'valid with place_id' do
    expect(create(:wallet, place_id: place.id)).to be_valid
  end

  it 'create user_wallets' do
    expect(wallet.user_wallets).to be_empty

    wallet.user_wallets << built_wallet

    expect(wallet.user_wallets).not_to be_empty
    expect(wallet.user_wallets.count).to eq(1)
  end

  it 'get users via user_wallets' do
    expect(wallet.users).to be_empty

    wallet.user_wallets << built_wallet

    expect(wallet.users).not_to be_empty
    expect(wallet.users.count).to eq(1)
    expect(wallet.users.first).to eq(admin)
  end
end