class CreateGigsAgain < ActiveRecord::Migration[6.0]
  def change
    create_table :gigs do |t|
      t.references :creator, null: false, foreign_key: true
      t.string :brand_name
      t.string :state

      t.timestamps
    end
  end
end
