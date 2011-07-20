class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :nickname
      t.string :first_name
      t.string :last_name
      t.string :location
      t.text :description
      t.string :image
      t.string :phone
      t.text :urls
      t.string :token
      t.string :secret
      t.text :user_hash

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
