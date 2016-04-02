class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :winner_id
      t.integer :loser_id
      t.belongs_to :list, index: true

      t.timestamps
    end
  end
end
