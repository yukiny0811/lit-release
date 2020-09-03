class CreateTeam < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :mentorname
      t.string :litclat_id
      t.timestamps null: false
    end
  end
end
