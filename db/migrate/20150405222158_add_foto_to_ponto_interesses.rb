class AddFotoToPontoInteresses < ActiveRecord::Migration
  def change
    add_column :ponto_interesses, :foto, :string
  end
end
