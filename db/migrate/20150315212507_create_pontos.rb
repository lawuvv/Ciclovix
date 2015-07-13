class CreatePontos < ActiveRecord::Migration
  def change
    create_table :pontos do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.float :altitude, :default => 0

      t.timestamps null: false
    end
  end
end
