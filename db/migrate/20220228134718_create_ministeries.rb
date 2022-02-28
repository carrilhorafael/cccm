class CreateMinisteries < ActiveRecord::Migration[6.1]
  def change
    create_table :ministeries do |t|
      t.string :name
      t.string :description
      t.references :church, null: false, foreign_key: true

      t.timestamps
    end
  end
end
