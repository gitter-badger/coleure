class ColoritemsController < ApplicationController
  before_action :set_coloritem, only: [:show, :edit, :update, :destroy]

  # GET /coloritems
  # GET /coloritems.json
  def index
    @coloritems = Coloritem.all
  end

  # GET /coloritems/1
  # GET /coloritems/1.json
  def show
  end

  # GET /coloritems/new
  def new
    @coloritem = Coloritem.new
  end

  # GET /coloritems/1/edit
  def edit
  end

  # POST /coloritems
  # POST /coloritems.json
  def create
    @coloritem = Coloritem.new(coloritem_params)

    respond_to do |format|
      if @coloritem.save
        format.html { redirect_to @coloritem, notice: 'Coloritem was successfully created.' }
        format.json { render :show, status: :created, location: @coloritem }
      else
        format.html { render :new }
        format.json { render json: @coloritem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coloritems/1
  # PATCH/PUT /coloritems/1.json
  def update
    respond_to do |format|
      if @coloritem.update(coloritem_params)
        format.html { redirect_to @coloritem, notice: 'Coloritem was successfully updated.' }
        format.json { render :show, status: :ok, location: @coloritem }
      else
        format.html { render :edit }
        format.json { render json: @coloritem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coloritems/1
  # DELETE /coloritems/1.json
  def destroy
    @coloritem.destroy
    respond_to do |format|
      format.html { redirect_to coloritems_url, notice: 'Coloritem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coloritem
      @coloritem = Coloritem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coloritem_params
      params.require(:coloritem).permit(:name, :hex, :mixed, :order, :colorpalette_id)
    end
end
