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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many  :places, dependent: :nullify
  has_many  :user_wallets, dependent: :destroy
  has_many  :wallets, through: :user_wallets

  attr_accessible :places, :wallets
  attr_accessible :user_name, :mobile_number, :email, :device_id, :push_token, :role, :password

  enum role: [:user, :admin]

  validates_presence_of :role

  # We don't need password field but still wanna have functionality which devise provides us
  # So let's set default password for all users if we don't provide user password
  before_validation { |record| record.password = 'password' if record.password.blank? }
end
