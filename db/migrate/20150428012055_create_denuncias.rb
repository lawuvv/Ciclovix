class CreateDenuncias < ActiveRecord::Migration
  def change
    create_table :denuncias do |t|
      t.integer :user_id
      t.integer :ponto_interesse_id
      t.integer :rota_id
      t.integer :motivo_id
      t.string :type

      t.timestamps null: false
    end
  end
end
