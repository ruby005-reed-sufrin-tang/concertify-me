class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :city
      t.string :state
      t.string :artist

      t.timestamps
    end
  end
end
