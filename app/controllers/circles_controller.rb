class CirclesController < ApplicationController
  before_action :set_circle, only: %i[details show edit update destroy]
  after_action :verify_authorized, if: -> { Rails.env.development? }

  # GET /circles
  def index
    authorize Circle
    @circles = Circle.all
  end

  # GET /circles/1
  def show
    authorize @circle
    @albums = Album.where(circle: @circle).order(created_at: :desc)
    render 'albums/index'
  end

  # GET /circles/1/details
  def details
    authorize @circle
  end

  # GET /circles/new
  def new
    authorize Circle
    @circle = Circle.new
  end

  # GET /circles/1/edit
  def edit
    authorize @circle
  end

  # POST /circles
  def create
    authorize Circle
    @render_target = :new

    @circle = Circle.new(circle_params)
    @circle.logo = params[:circle][:logo]

    if @circle.save
      redirect_to @circle, notice: 'Kör sikeresen létrehozva.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PUT /circles/1
  def update
    authorize @circle
    @render_target = :edit

    if @circle.update(circle_params)
      redirect_to @circle, notice: 'Kör sikeresen módosítva.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /circles/1
  def destroy
    authorize @circle
    @circle.destroy
    redirect_to circles_url, notice: 'Kör sikeresen törölve.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_circle
    @circle = Circle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def circle_params
    params.require(:circle).permit(:name)
  end
end
