class ColorsController < ApplicationController
  def create
    @palette = Palette.with_color(color_params)

    respond_to do |format|
      format.html { redirect_to edit_palette_path(@palette) }
      format.json { render json: @palette }
    end
  end

  def destroy
    @color   = Color.find(params[:id])
    @palette = @color.palette.without_color(@color.hex)

    respond_to do |format|
      format.html { redirect_to edit_palette_path(@palette) }
      format.json { render json: @palette }
    end
  end

  private

  def color_params
    params.require(:color).permit(:palette_id, :name, :hex, :rgb, :hsl, :mixed)
  end
end
