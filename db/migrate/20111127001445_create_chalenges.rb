class CreateChalenges < ActiveRecord::Migration
  def change
    create_table :chalenges do |t|
      t.binary :gt
      t.string :gtfileext
      t.string :gtfilename
      t.binary :input
      t.string :inputfileext
      t.string :inputfilename
      t.string :name
      t.references :Dataset

      t.timestamps
    end
    add_index :chalenges, :Dataset_id
  end
end
