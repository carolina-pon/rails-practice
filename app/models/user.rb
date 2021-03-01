# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  age             :integer
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :age, length: { maximum: 3 }
  validates :email, uniqueness: true, presence: true
  # password_digestにすることでpassword_confirmationが使える
  validates :password_digest, presence: true
end
