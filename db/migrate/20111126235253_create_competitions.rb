class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.text :description
      t.datetime :starttime
      t.datetime :endtime
      t.boolean :publicscore
	  t.references :User
      t.references :Dataset
      t.references :Evaluator
      t.timestamps
    end
	add_index :competitions, :User_id
	add_index :competitions, :Dataset_id
	add_index :competitions, :Evaluator_id
	add_index :competitions, :name,:null => false, :unique => true
  end
end
