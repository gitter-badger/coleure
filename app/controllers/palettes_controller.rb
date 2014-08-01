class PalettesController < ApplicationController
  before_action :set_palette, only: [:show, :edit]

  def new;  end
  def edit; end

  def index
    @palettes = Palette.all.order("created_at DESC")
    render layout: false
  end

  def show
    respond_to do |format|
      format.html { redirect_to edit_palette_path(@palette) }
      format.json { render json: @palette.colors.order("created_at DESC") }
    end
  end

  private

  def set_palette
    @palette = Palette.find(params[:id])
  end
end
