class SetDefaultStateValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default :gigs, :state,"applied"
  end
end
