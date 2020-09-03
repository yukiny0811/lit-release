class CreateAllDat < ActiveRecord::Migration[5.2]
  def change
    create_table :all_dats do |t|
      t.string :dataname
      t.string :datavalue
      t.timestamps null: false
    end
  end
end
