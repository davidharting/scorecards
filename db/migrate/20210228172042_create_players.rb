class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :scorecard, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
