require 'test_helper'

class ColorpalettesControllerTest < ActionController::TestCase
  setup do
    @colorpalette = colorpalettes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:colorpalettes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create colorpalette" do
    assert_difference('Colorpalette.count') do
      post :create, colorpalette: { name: @colorpalette.name }
    end

    assert_redirected_to colorpalette_path(assigns(:colorpalette))
  end

  test "should show colorpalette" do
    get :show, id: @colorpalette
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @colorpalette
    assert_response :success
  end

  test "should update colorpalette" do
    patch :update, id: @colorpalette, colorpalette: { name: @colorpalette.name }
    assert_redirected_to colorpalette_path(assigns(:colorpalette))
  end

  test "should destroy colorpalette" do
    assert_difference('Colorpalette.count', -1) do
      delete :destroy, id: @colorpalette
    end

    assert_redirected_to colorpalettes_path
  end
end
