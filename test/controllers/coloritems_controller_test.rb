require 'test_helper'

class ColoritemsControllerTest < ActionController::TestCase
  setup do
    @coloritem = coloritems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coloritems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coloritem" do
    assert_difference('Coloritem.count') do
      post :create, coloritem: { hex: @coloritem.hex, mixed: @coloritem.mixed, name: @coloritem.name, order: @coloritem.order, palette_id: @coloritem.palette_id }
    end

    assert_redirected_to coloritem_path(assigns(:coloritem))
  end

  test "should show coloritem" do
    get :show, id: @coloritem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coloritem
    assert_response :success
  end

  test "should update coloritem" do
    patch :update, id: @coloritem, coloritem: { hex: @coloritem.hex, mixed: @coloritem.mixed, name: @coloritem.name, order: @coloritem.order, palette_id: @coloritem.palette_id }
    assert_redirected_to coloritem_path(assigns(:coloritem))
  end

  test "should destroy coloritem" do
    assert_difference('Coloritem.count', -1) do
      delete :destroy, id: @coloritem
    end

    assert_redirected_to coloritems_path
  end
end
