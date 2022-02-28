class AddChurchToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :church, null: false, foreign_key: true
  end
end
