class CreatePontoInteresses < ActiveRecord::Migration
  def change
    create_table :ponto_interesses do |t|
      t.string :nome, null: false
      t.string :descricao
      t.string :endereco, null: false
      t.string :url
      t.integer :tipo_id, index: true
      t.integer :user_id, index: true
      t.integer :ponto_id, index: true
      t.boolean :enable, :default => true

      t.timestamps null: false
    end
  end
end
