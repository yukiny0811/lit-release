class CreateMember < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :membername
      t.integer :percentage
      t.string :team_id
      t.timestamps null: false
    end
  end
end
