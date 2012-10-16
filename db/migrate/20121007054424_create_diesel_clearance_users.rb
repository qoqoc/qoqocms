class CreateDieselClearanceUsers < ActiveRecord::Migration
  def self.up
    create_table :qoqocms_users do |t|
      t.string   :email
      t.string   :encrypted_password, :limit => 128
      t.string   :salt,               :limit => 128
      t.string   :confirmation_token, :limit => 128
      t.string   :remember_token,     :limit => 128
      t.timestamps
    end

    add_index :qoqocms_users, :email
    add_index :qoqocms_users, :remember_token
  end

  def self.down
    drop_table :qoqocms_users
  end
end
