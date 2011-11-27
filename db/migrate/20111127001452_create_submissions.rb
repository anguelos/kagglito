class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.binary :responce
      t.string :responcefileext
      t.datetime :announced
      t.datetime :submited
      t.float :score
      t.references :Chalenge
      t.references :participation

      t.timestamps
    end
    add_index :submissions, :Chalenge_id
    add_index :submissions, :participation_id
  end
end
