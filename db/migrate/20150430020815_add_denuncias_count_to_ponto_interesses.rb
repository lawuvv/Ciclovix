class AddDenunciasCountToPontoInteresses < ActiveRecord::Migration
  def change
    add_column :ponto_interesses, :denuncias_count, :integer, :default => 0
  end
end
