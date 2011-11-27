class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.text :description
      t.datetime :starttime
      t.datetime :endtime
      t.boolean :publicscore

      t.timestamps
    end
  end
end
