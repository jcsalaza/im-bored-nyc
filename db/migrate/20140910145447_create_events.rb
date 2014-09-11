class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.text :description
      t.string :time

      t.timestamps
    end
  end
end

# maybe add specific fields for time (I believe it's in description) and whether or not it's a free event

