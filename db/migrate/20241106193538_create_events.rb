class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :event_name, null: false
      t.datetime :event_date, null: false
      t.text :description, null: false
      t.integer :status, null: false, default: 0 #Enum (soon - available - sold)
      t.integer :capacity, null: false

      t.timestamps
    end
  end
end
