class CreateTipos < ActiveRecord::Migration
  def change
    create_table :tipos do |t|
      t.string :type, null: false
      t.string :descricao, null: false
      t.string :marcador, null: false
      t.boolean :enable, :default => true

      t.timestamps null: false
    end
  end
end
