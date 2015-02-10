class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string      :name
      t.text        :description
      t.boolean     :private, default: false
      t.references  :team, index: true

      t.timestamps null: false
    end
  end
end
