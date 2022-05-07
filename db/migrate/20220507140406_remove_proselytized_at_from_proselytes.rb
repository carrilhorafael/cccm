class RemoveProselytizedAtFromProselytes < ActiveRecord::Migration[6.1]
  def change
    add_reference :proselytes, :cult, foreign_key: true
  end
end
