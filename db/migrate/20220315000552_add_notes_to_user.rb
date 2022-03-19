class AddNotesToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :notes, :string
  end
end
