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

require 'rails_helper'

describe Place do
  let(:admin) { create(:admin) }
  let(:place) { create(:place, user: admin) }
  let(:wallet) { create(:wallet, place: place) }

  it 'has valid factory' do
    expect(build(:place)).to be_valid
  end

  it 'valid without user' do
    expect(build(:place)).to be_valid
  end

  it 'valid with user' do
    expect(build(:place, user: admin)).to be_valid
  end

  it 'invalid without name' do
    expect(build(:place, name: nil)).not_to be_valid
  end

  it 'creates with user_id' do
    new_place = create(:place, user_id: admin.id)

    expect(new_place.user).to eq(admin)
  end

  it 'creates with user' do
    new_place = create(:place, user: admin)

    expect(new_place.user).to eq(admin)
  end

  it 'valid with cover_image' do
    expect(create(:place)).to be_valid
  end

  it 'valid without cover_image' do
    expect(create(:place, cover_image: nil)).to be_valid
  end

  it 'assigns wallets' do
    new_place = create(:place, user: admin)

    expect(new_place.wallets).to be_empty

    new_place.wallets << wallet

    expect(new_place.wallets).not_to be_empty
    expect(new_place.wallets.count).to eq(1)
    expect(new_place.wallets.first).to eq(wallet)
  end
end
