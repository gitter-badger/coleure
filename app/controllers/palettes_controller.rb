class PalettesController < ApplicationController
  before_action :current_resource, only: [:show, :edit, :download]

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

  def download
    doc = ASE.new
    ase_palette = ASE::Palette.new(@palette.id.to_s)
    for color in @palette.colors
      ase_palette.add color.name, ASE::Color::RGB.from_hex(color.hex)
    end
    doc << ase_palette
    root = Rails.root.to_s
    file = ("#{root}/tmp/#{@palette.id}.ase").to_s
    doc.to_file(file)
    send_file file
  end

  private

  def current_resource
    @palette = Palette.find(params[:id]) if params[:id].present?
  end
end
