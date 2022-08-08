class CreateGigPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :gig_payments do |t|
      t.references :gig, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
