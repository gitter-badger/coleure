class ColorsController < ApplicationController
  def create
    palette = Palette.with_color(color_params)

    redirect_to edit_palette_path(palette)
  end

  def destroy
    color   = Color.find(params[:id])
    palette = color.palette.without_color(color.hex)

    redirect_to edit_palette_path(palette)
  end

  private

  def color_params
    params.require(:color).permit(:palette_id, :name, :hex, :mixed)
  end
end
