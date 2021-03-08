class CreateRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :rounds do |t|
      t.references :scorecard, null: false, foreign_key: true
      t.integer :number, null: false

      t.timestamps
    end
  end
end
