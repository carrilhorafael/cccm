class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :is_leader, default: false
      t.string :title
      t.references :collection, null: false, polymorphic: true

      t.timestamps
    end
  end
end
