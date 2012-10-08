class CreateUserRequests < ActiveRecord::Migration
  def change
    create_table :user_requests do |t|
      t.string :name
      t.string :address
      t.string :phones
      t.string :email
      t.string :message

      t.timestamps
    end
  end
end
