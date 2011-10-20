class CreateCredentials < ActiveRecord::Migration
  def self.up
    create_table :credentials do |t|
      t.references :user
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
      t.string :refresh_token
      t.integer :expires_at
      t.datetime :issued_at
      t.text :user_hash
      t.text :profile_api_data
      t.timestamps
    end
    add_index :credentials, [:provider, :uid]
  end

  def self.down
    drop_table :credentials
  end
end
