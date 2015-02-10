class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text        :content, limit: 2014
      t.references  :todo_list, index: true
      t.datetime    :completed_on
      t.boolean     :active,  default: false
      t.references  :user, index: true

      t.timestamps null: false
    end
  end
end
