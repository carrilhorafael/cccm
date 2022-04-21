class CreateProselytes < ActiveRecord::Migration[6.1]
  def change
    create_table :proselytes do |t|
      t.string :name
      t.date :proselytized_at
      t.string :phone
      t.references :church, null: false, foreign_key: true

      t.timestamps
    end
  end
end
