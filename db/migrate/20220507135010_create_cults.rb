class CreateCults < ActiveRecord::Migration[6.1]
  def change
    create_table :cults do |t|
      t.date :date_of
      t.string :responsible_name
      t.string :description
      t.references :church

      t.timestamps
    end
  end
end
