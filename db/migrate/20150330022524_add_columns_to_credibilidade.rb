class AddColumnsToCredibilidade < ActiveRecord::Migration
  def change
  	add_column :credibilidades, :ponto_interesse_id, :integer
  	add_column :credibilidades, :rota_id, :integer
  end
end
