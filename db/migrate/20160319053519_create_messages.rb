class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :username
      t.text :title
      t.text :content
      t.timestamps null: false
    end
  end
end
