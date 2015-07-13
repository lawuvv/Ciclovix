# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# CONFIGURAÇÕES BÁSICAS

# Todo ponto deverá ser cadastrado no Estado/UF:
CONFIG_ESTADO = 'Espírito Santo'
CONFIG_UF = 'ES'

# No cadastro de um novo ponto, o mapa será renderizado na posição:
CONFIG_LATITUDE = -20.32379941
CONFIG_LONGITUDE = -40.28363723

# Nomes para exibição
CONFIG_NOME_SISTEMA = 'CicloVix'
CONFIG_TITULO = 'Mapa Cicloviário da Grande Vitória'