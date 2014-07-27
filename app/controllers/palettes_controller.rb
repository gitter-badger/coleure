class PalettesController < ApplicationController
  before_action :set_palette, only: [:show, :edit]

  def new;  end
  def edit; end

  def show
    redirect_to edit_palette_path(@palette)
  end

  private

  def set_palette
    @palette = Palette.find(params[:id])
  end
end
