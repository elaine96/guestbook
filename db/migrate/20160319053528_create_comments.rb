class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :username
      t.text :content
      t.text :message_id
      t.timestamps
    end
  end
end
