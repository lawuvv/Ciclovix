class CreateTipoRotas < ActiveRecord::Migration
  def change
  	Tipo.create descricao: "Ciclovia", marcador: "#ff0000ff", type: "TipoRota"
  	Tipo.create descricao: "Ciclovia em obras", marcador: "#ff0000a8", type: "TipoRota"
  	Tipo.create descricao: "Ciclorrota adequada", marcador: "#ff00a838", type: "TipoRota"
  	Tipo.create descricao: "Ciclorrota com tráfego intenso", marcador: "#ff00aaff", type: "TipoRota"
  end
end
