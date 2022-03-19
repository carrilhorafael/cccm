class RemoveNotesFromMembership < ActiveRecord::Migration[6.1]
  def change
    remove_column :memberships, :is_leader, :boolean
    remove_column :memberships, :notes, :string
  end
end
