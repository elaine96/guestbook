class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.text :username
    	t.text :password
    	t.text :repassword
    	t.text :email
      t.timestamps
    end
  end
end
