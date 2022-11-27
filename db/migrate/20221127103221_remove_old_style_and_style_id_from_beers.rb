class RemoveOldStyleAndStyleIdFromBeers < ActiveRecord::Migration[7.0]
  def change
    add_reference :beers, :style, foreign_key: true
    s = Style.create({ :name => 'Migration', :description => 'Migration, please select correct style.'})
    Beer.update_all(:style => s)
    remove_column :beers, :style, :string
  end
end
