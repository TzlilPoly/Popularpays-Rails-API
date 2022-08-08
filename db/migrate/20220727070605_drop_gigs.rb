class DropGigs < ActiveRecord::Migration[6.0]
  def change
    drop_table :gigs
  end
end
