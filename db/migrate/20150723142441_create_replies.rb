class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|

      t.integer :post_id
      t.string :d_name
      t.string :d_password
      t.string :d_reply

      t.timestamps null: false
    end
  end
end
