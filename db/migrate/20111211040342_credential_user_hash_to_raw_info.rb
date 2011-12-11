class CredentialUserHashToRawInfo < ActiveRecord::Migration
  def up
  	rename_column :credentials, :user_hash, :raw_info
  end

  def down
  	rename_column :credentials, :raw_info, :user_hash
  end
end
