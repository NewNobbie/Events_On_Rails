class CreateTickets < ActiveRecord::Migration[7.2]
  def change
    create_table :tickets do |t|
      t.references :event, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.datetime :ticket_date, null: false
      t.integer :seat, null: false

      t.timestamps
    end
  end
end
