class RemoveOldStyleAndStyleIdFromBeers < ActiveRecord::Migration[7.0]
  def change
    add_reference :beers, :style, foreign_key: true
    Beer.update_all(:style_id => 1)
    remove_column :beers, :style, :string
  end
end
