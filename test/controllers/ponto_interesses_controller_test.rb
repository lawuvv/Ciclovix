require 'test_helper'

class PontoInteressesControllerTest < ActionController::TestCase
  setup do
    @ponto_interess = ponto_interesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ponto_interesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ponto_interess" do
    assert_difference('PontoInteresse.count') do
      post :create, ponto_interess: { descricao: @ponto_interess.descricao, enable: @ponto_interess.enable, endereco: @ponto_interess.endereco, nome: @ponto_interess.nome, tipo_id: @ponto_interess.tipo_id, url: @ponto_interess.url, user_id: @ponto_interess.user_id }
    end

    assert_redirected_to ponto_interess_path(assigns(:ponto_interess))
  end

  test "should show ponto_interess" do
    get :show, id: @ponto_interess
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ponto_interess
    assert_response :success
  end

  test "should update ponto_interess" do
    patch :update, id: @ponto_interess, ponto_interess: { descricao: @ponto_interess.descricao, enable: @ponto_interess.enable, endereco: @ponto_interess.endereco, nome: @ponto_interess.nome, tipo_id: @ponto_interess.tipo_id, url: @ponto_interess.url, user_id: @ponto_interess.user_id }
    assert_redirected_to ponto_interess_path(assigns(:ponto_interess))
  end

  test "should destroy ponto_interess" do
    assert_difference('PontoInteresse.count', -1) do
      delete :destroy, id: @ponto_interess
    end

    assert_redirected_to ponto_interesses_path
  end
end
