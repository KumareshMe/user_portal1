class CreateUserPortals < ActiveRecord::Migration[5.0]
  def change
    create_table :user_portals, id: :uuid do |t|
      t.string :first_name, index: true
      t.string :last_name, index: true
      t.integer :role, index: true
      t.string :image

      t.timestamps
    end
  end
end
