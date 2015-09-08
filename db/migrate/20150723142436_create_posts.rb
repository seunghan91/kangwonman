class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :post_username
      t.string :post_password
      t.text   :post_content

      t.timestamps null: false
    end
  end
end
