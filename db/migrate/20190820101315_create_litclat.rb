class CreateLitclat < ActiveRecord::Migration[5.2]
  def change
    create_table :litclats do |t|
      t.string :classname
      t.timestamps null: false
      t.string :season_id
    end
  end
end
