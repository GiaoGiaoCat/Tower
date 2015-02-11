class AddDeletedAtToTodosAndComments < ActiveRecord::Migration
  def change
    add_column :todos, :deleted_at, :datetime
    add_column :comments, :deleted_at, :datetime
  end
end
