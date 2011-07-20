class AddIndexForProviderAndUidOnUsers < ActiveRecord::Migration
  def self.up
    add_index :users, [:provider, :uid]
  end

  def self.down
    remove_index :users, [:provider, :uid]
  end
end
