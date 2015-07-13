class CreateTipoDenuncia < ActiveRecord::Migration
  def change
  	Tipo.create descricao: "Conteúdo impróprio / ofensivo / pornográfico", marcador: "TipoDenunciaPonto", type: "TipoDenuncia"
  	Tipo.create descricao: "Conteúdo aleatório, como se fosse um teste.", marcador: "TipoDenunciaPonto", type: "TipoDenuncia"
  	Tipo.create descricao: "Dados incorretos (endereço, nome, etc.)", marcador: "TipoDenunciaPonto", type: "TipoDenuncia"
  	Tipo.create descricao: "Sou o responsável pelo estabelecimento, e não quero ele aqui.", marcador: "TipoDenunciaPonto", type: "TipoDenuncia"
  end
end