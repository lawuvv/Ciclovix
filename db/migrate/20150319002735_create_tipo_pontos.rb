class CreateTipoPontos < ActiveRecord::Migration
  def change
  	Tipo.create descricao: "Oficina de Conserto", marcador: "repair.png", type: "TipoPonto"
  	Tipo.create descricao: "Loja de Compra/Venda", marcador: "bicycle_shop.png", type: "TipoPonto"
  	Tipo.create descricao: "Bicicletário", marcador: "bicycle_parking.png", type: "TipoPonto"
  	Tipo.create descricao: "Aluguel de Bicicletas", marcador: "e-bike-rental.png", type: "TipoPonto"
  	Tipo.create descricao: "Ponto de Ônibus", marcador: "busstop.png", type: "TipoPonto"
  	Tipo.create descricao: "Ponto Problemático", marcador: "star.png", type: "TipoPonto"
  	Tipo.create descricao: "Concentração dos Passeios", marcador: "regroup.png", type: "TipoPonto"
  end
end
