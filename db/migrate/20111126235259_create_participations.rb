class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.boolean :submissionspublic
      t.references :User
      t.references :Competition

      t.timestamps
    end
    add_index :participations, :User_id
    add_index :participations, :Competition_id
  end
end
