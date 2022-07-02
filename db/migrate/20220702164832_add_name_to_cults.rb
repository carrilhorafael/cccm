class AddNameToCults < ActiveRecord::Migration[6.1]
  def change
    add_column :cults, :name, :string
    remove_column :cults, :date_of, :date
    add_column :cults, :date_of, :datetime
    add_reference :cults, :responsible, { to_table: :users }
  end
end
