class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :phone
      t.string :title
      t.boolean :is_leader, default: false
      t.datetime :last_time_logged_at
      t.boolean :president_pastor, default: false
      t.string :validation_token
      t.datetime :validation_token_sent_at
      t.datetime :access_garantied_at
      t.string :access_garantied_by
      t.references :church, foreign_key: true
      t.date :birthdate
      t.integer :marital_status
      t.string :location
      t.date :member_since
      t.boolean :is_baptized, default: false
      t.integer :gender

      t.timestamps
    end
  end
end
