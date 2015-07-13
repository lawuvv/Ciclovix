class CreateCredibilidades < ActiveRecord::Migration
  def change
    create_table :credibilidades do |t|
      t.integer :valor, null: false
      t.integer :user_id, null: false
      t.boolean :enable, :default => true
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
