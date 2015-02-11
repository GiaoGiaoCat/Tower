class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer     :source_id
      t.string      :source_type
      t.references  :user, index: true
      t.string      :action
      t.references  :project, index: true

      t.timestamps null: false
    end

    add_index :events, [:source_id, :source_type], name: "index_events_on_source_id_and_source_type"
  end
end
