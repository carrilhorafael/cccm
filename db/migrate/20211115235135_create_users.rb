class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.boolean :is_master, default: false
      t.boolean :is_manager, default: false
      t.datetime :last_time_logged_at
      t.string :validation_token
      t.datetime :validation_token_sent_at
      t.date :birthdate
      t.integer :marital_status
      t.string :location
      t.integer :branch, default: 0
      t.date :member_since
      t.boolean :is_baptized, default: false
      t.integer :gender, default: 0

      t.timestamps
    end
  end
end
