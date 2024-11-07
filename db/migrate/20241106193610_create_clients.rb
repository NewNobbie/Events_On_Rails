class CreateClients < ActiveRecord::Migration[7.2]
  def change
    create_table :clients do |t|
      t.string :client_name, null: false
      t.string :mail, null: false, unique: true

      t.timestamps
    end
    add_index :clients, :mail, unique: true # Ensure unique mail
  end
end
