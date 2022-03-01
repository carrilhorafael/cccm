class CreateChurches < ActiveRecord::Migration[6.1]
  def change
    create_table :churches do |t|
      t.string :name
      t.string :location
      t.boolean :is_head, default: false

      t.timestamps
    end
  end
end
