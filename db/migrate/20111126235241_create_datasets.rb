class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :name
      t.boolean :gtpublic
      t.boolean :inputpublic
      t.text :description

      t.timestamps
    end
  end
end
