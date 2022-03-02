class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ministery, null: false, foreign_key: true
      t.string :notes
      t.boolean :is_leader, default: false

      t.timestamps
    end
  end
end
