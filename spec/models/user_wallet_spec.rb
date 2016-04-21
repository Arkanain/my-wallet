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

require 'rails_helper'

describe UserWallet do
  let(:admin) { create(:admin) }
  let(:place) { create(:place, user: admin) }
  let(:wallet) { create(:wallet, place: place) }
  let(:user_wallet) { create(:user_wallet, user: admin, wallet: wallet) }

  it 'has valid factory' do
    expect(build(:user_wallet, user: admin, wallet: wallet)).to be_valid
  end

  it 'invalid without serial number' do
    expect(build(:user_wallet, user: admin, wallet: wallet, serial_number: nil)).not_to be_valid
  end

  it 'invalid without user' do
    expect(build(:user_wallet, wallet: wallet)).not_to be_valid
  end

  it 'invalid without wallet' do
    expect(build(:user_wallet, user: admin)).not_to be_valid
  end

  it 'get assigned user' do
    expect(user_wallet.user).to eq(admin)
  end

  it 'get assigned wallet' do
    expect(user_wallet.wallet).to eq(wallet)
  end
end
