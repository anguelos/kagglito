class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.binary :response
      t.string :responsefileext
      t.datetime :announced
      t.datetime :submited
      t.float :score
      t.references :Chalenge
      t.references :Participation
      t.references :User
      t.timestamps
    end
    add_index :submissions, :Chalenge_id
    add_index :submissions, :Participation_id
    add_index :submissions, :User_id
  end
end
