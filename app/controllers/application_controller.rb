class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  helper :all

  # verifica se o usuário que tenta acessar a página de ADMIN é de fato um administrador
  def authenticate_admin
    deny_access('Você não possui acesso à essa página') unless current_user.try(:admin?)
  end

  # verifica se o usuário que tenta editar um Ponto é o criador do mesmo ou admin
  def authenticate_edit_point(ponto)
    necessary = !current_user.try(:admin?) and ponto.user_id != current_user.id
    deny_access("Você está tentando editar um Ponto que não é seu.") if necessary
  end

  # Um Ponto desabilitado só poderá ser visto por:
  # Usuário autenticado e criador do Ponto
  # Usuário Administrador
  def authenticate_show_point(ponto)
    msg = 'O Ponto que você acessou foi Desabilitado :('
    deny_access(msg) if !user_signed_in? and !ponto.enable
    deny_access(msg) if user_signed_in? and !current_user.try(:admin?) and !ponto.enable 
    deny_access(msg) if user_signed_in? and ponto.user_id != current_user.id and !ponto.enable
  end

  def deny_access(msg)
    redirect_to root_url, :alert => msg
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit :name, :email, :password, :password_confirmation, :locale, :gender
      end
    end

end
