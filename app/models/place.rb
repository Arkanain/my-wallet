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

class Place < ActiveRecord::Base
  has_many :wallets, dependent: :destroy

  belongs_to :user

  attr_accessible :user, :wallets
  attr_accessible :name, :cover_image

  validates_presence_of :name
end
