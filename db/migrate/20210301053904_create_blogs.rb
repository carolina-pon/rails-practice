class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|

      t.string :title, null: false
      t.string :body, null: false
      # デフォルト値を0 = 公開 とする
      t.integer :status,null: false, default: 0
      # 外部キー制約がついたuser_idカラムを作成
      t.references :user, foreign_key: true
      t.timestamps
    end

  end
end
