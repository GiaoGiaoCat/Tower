class AddExpiryOnToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :expiry_on, :datetime
  end
end
