require 'test_helper'

class CredibilidadesControllerTest < ActionController::TestCase
  setup do
    @credibilidade = credibilidades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:credibilidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create credibilidade" do
    assert_difference('Credibilidade.count') do
      post :create, credibilidade: { enable: @credibilidade.enable, type: @credibilidade.type, user_id: @credibilidade.user_id, valor: @credibilidade.valor }
    end

    assert_redirected_to credibilidade_path(assigns(:credibilidade))
  end

  test "should show credibilidade" do
    get :show, id: @credibilidade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @credibilidade
    assert_response :success
  end

  test "should update credibilidade" do
    patch :update, id: @credibilidade, credibilidade: { enable: @credibilidade.enable, type: @credibilidade.type, user_id: @credibilidade.user_id, valor: @credibilidade.valor }
    assert_redirected_to credibilidade_path(assigns(:credibilidade))
  end

  test "should destroy credibilidade" do
    assert_difference('Credibilidade.count', -1) do
      delete :destroy, id: @credibilidade
    end

    assert_redirected_to credibilidades_path
  end
end
