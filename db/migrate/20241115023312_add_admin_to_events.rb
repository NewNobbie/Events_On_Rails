class AddAdminToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :admin_id, :integer
    add_foreign_key :events, :clients, column: :admin_id
  end
end
