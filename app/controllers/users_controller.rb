class UsersController < ApplicationController

  layout "flatpage"

  def new
  end

  def create
    @user.assign_attributes user_params

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to @user
    else
      render :edit
    end
  end

private

  def set_user
    @user = params[:id].present? ? User.find(params[:id]) : User.new
  end

  def user_params
    params.require(:user).permit :name, :email, :password
  end

  def current_resource
    @user ||= params[:id].present? ? User.find(params[:id]) : User.new
  end
end
