module ApplicationHelper

	# Obtem o nome da classe css que estiliza a mensagem em flash
	def get_flash_class(name)
		css_class = 'info' # azul (padrão)
		case name.to_s
		when 'success'
		  css_class = 'success' # verde
		when 'warning'
		  css_class = 'warning' # laranja
	  when 'alert'
		  css_class = 'warning' # laranja
		when 'error'
		  css_class = 'danger' # vermelho
		when 'recaptcha_error'
		  css_class = 'danger' # vermelho
		end
		css_class
	end
	
end