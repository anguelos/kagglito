class CreateEvaluators < ActiveRecord::Migration
  def change
    create_table :evaluators do |t|
      t.string :name
      t.text :description
      t.float :minvalue
      t.float :maxvalue
      t.binary :src
      t.references :User

      t.timestamps
    end
    add_index :evaluators, :User_id
  end
end
