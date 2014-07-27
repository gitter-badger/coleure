class PalettesController < ApplicationController
  before_action :set_palette

  def show
    redirect_to edit_palette_path(@palette)
  end

  def edit
  end

  private

  def set_palette
    @palette = Palete.find(params[:id])
  end
end
