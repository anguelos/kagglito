class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.boolean :submissionspublic
	  t.string :name
	  t.text :description
      t.references :User
      t.references :Competition
      t.timestamps
    end
    add_index :participations, :User_id
    add_index :participations, :Competition_id
	add_index :participations, :name,:null => false, :unique => true
  end
end
