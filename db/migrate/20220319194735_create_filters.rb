class CreateFilters < ActiveRecord::Migration[6.1]
  def change
    create_table :filters do |t|
      t.references :user, null: false, foreign_key: true
      t.string :source
      t.string :sortable, default: 'system_access'
      t.json :restriction, default: {}

      t.timestamps
    end
  end
end
