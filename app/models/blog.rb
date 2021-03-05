# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  status     :integer          default(0), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_blogs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Blog < ApplicationRecord
  belongs_to :user
  # titleは20文字以下
  validates :title, presence: true, length: { maximum: 20 }
  # bodyは100文字以下
  validates :body, presence: true, length: { maximum: 100 }
  # 公開・非公開の設定にenumを使用
  enum status: { published: 0, unpublished: 1 }
end
