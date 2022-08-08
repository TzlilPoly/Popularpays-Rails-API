class CreateApiKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :api_keys do |t|
      t.string :key
      t.boolean :creator_access
      t.boolean :gig_access
      t.boolean :gig_payment_access
      t.timestamps
    end
  end
end
