class CreateApples < ActiveRecord::Migration
  def change
    create_table :apples do |t|

      t.timestamps
    end
  end
end
