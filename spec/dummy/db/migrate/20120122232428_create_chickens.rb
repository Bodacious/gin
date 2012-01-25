class CreateChickens < ActiveRecord::Migration
  def change
    create_table :chickens do |t|
      t.string :name
      t.references :apple

      t.timestamps
    end
    add_index :chickens, :apple_id
  end
end
