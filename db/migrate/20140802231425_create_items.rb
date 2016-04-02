class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :img_url
      t.text :description
      t.belongs_to :rscope

      t.timestamps
    end
  end
end
