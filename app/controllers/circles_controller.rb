class CirclesController < ApplicationController
  before_action :set_circle, only: %i[edit update destroy]
  before_action :site_admin_required

  # GET /circles
  def index
    @circles = Circle.all
  end

  # GET /circles/1
  def show
    @circle = Circle.find(params[:id])
  end

  # GET /circles/new
  def new
    @circle = Circle.new
  end

  # GET /circles/1/edit
  def edit; end

  # POST /circles
  def create
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
    @render_target = :edit

    if @circle.update(circle_params)
      redirect_to @circle, notice: 'Kör sikeresen módosítva.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /circles/1
  def destroy
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
