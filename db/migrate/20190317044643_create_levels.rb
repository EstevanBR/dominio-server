class CreateLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :levels do |t|
      t.string :name
      t.jsonb :data

      t.timestamps
    end
  end
end
