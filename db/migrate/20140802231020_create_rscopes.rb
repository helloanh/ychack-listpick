class CreateRscopes < ActiveRecord::Migration
  def change
    create_table :rscopes do |t|
      t.string :unit
      t.string :quantity

      t.timestamps
    end
  end
end
