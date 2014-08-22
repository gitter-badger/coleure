class PalettesController < ApplicationController

  def new;  end
  def edit; end

  def index
    @palettes = Palette.all.order("created_at DESC")
    render layout: false
  end

  def user
    @user = current_user
    render layout: false
  end

  def show
    respond_to do |format|
      format.html { render "show" }
      format.json { render json: @palette.colors }
    end
  end

  private

  def current_resource
    @palette = Palette.find(params[:id]) if params[:id].present?
  end
end
