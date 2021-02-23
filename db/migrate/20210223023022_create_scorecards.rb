class CreateScorecards < ActiveRecord::Migration[6.1]
  def change
    create_table :scorecards do |t|
      t.string :name, limit: 280
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
