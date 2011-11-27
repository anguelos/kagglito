class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :name
      t.boolean :gtpublic
      t.boolean :inputpublic
      t.text :description
      t.references :User

      t.timestamps
    end
	add_index :datasets, :User_id
  end
end
