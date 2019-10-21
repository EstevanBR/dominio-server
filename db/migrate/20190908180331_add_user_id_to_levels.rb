class AddUserIdToLevels < ActiveRecord::Migration[5.1]
  def change
    add_column :levels, :user_id, :int
  end
end
