class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :facebook_link

      t.timestamps
    end
  end
end
