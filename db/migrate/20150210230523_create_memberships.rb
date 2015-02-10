class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string      :role, limit: 20
      t.references  :team, index: true
      t.references  :user, index: true

      t.timestamps null: false
    end
  end
end
