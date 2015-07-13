class Tipo < ActiveRecord::Base
	validates :descricao, :presence => {:message => ' não pode ficar em branco'}
	validates :marcador, :presence => {:message => ' não pode ficar em branco'}
end
