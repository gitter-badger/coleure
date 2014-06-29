class ColorpalettesController < ApplicationController
  before_action :set_colorpalette, only: [:show, :edit, :update, :destroy]

  # GET /colorpalettes
  # GET /colorpalettes.json
  def index
    @colorpalettes = Colorpalette.all
  end

  # GET /colorpalettes/1
  # GET /colorpalettes/1.json
  def show
  end

  # GET /colorpalettes/new
  def new
    @colorpalette = Colorpalette.new
  end

  # GET /colorpalettes/1/edit
  def edit
  end

  # POST /colorpalettes
  # POST /colorpalettes.json
  def create
    @colorpalette = Colorpalette.new(colorpalette_params)

    respond_to do |format|
      if @colorpalette.save
        format.html { redirect_to @colorpalette, notice: 'Colorpalette was successfully created.' }
        format.json { render :show, status: :created, location: @colorpalette }
      else
        format.html { render :new }
        format.json { render json: @colorpalette.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colorpalettes/1
  # PATCH/PUT /colorpalettes/1.json
  def update
    respond_to do |format|
      if @colorpalette.update(colorpalette_params)
        format.html { redirect_to @colorpalette, notice: 'Colorpalette was successfully updated.' }
        format.json { render :show, status: :ok, location: @colorpalette }
      else
        format.html { render :edit }
        format.json { render json: @colorpalette.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colorpalettes/1
  # DELETE /colorpalettes/1.json
  def destroy
    @colorpalette.destroy
    respond_to do |format|
      format.html { redirect_to colorpalettes_url, notice: 'Colorpalette was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colorpalette
      @colorpalette = Colorpalette.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def colorpalette_params
      params.require(:colorpalette).permit(:name)
    end
end
