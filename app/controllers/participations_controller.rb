class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[ show edit update destroy ]
  before_action :login_required

  # GET /participations
  def index
    @participations = Participation.all
  end

  # GET /participations/1
  def show
  end

  # GET /events/1/register
  def new
    event = Event.find(params[:event_id])
    if event.event_type.nil?
      redirect_to root_url, notice: "Ehhez az eseményhez nincs jelentkező űrlap"
    elsif event.participations.exists?(user: current_user)
      redirect_to root_url, notice: "Erre az eseményre már regisztráltál"
    else
      @event_type    = event.event_type
      @participation = Participation.new(event: event)
    end
  end

  # GET /participations/1/edit
  def edit
    @event_type = @participation.event.event_type
  end

  # POST /participations
  def create
    @participation      = Participation.new(participation_create_params)
    @participation.user = current_user

    if @participation.save
      render json: { redirect: participation_path(@participation) }, status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /participations/1
  def update
    if @participation.update(participation_update_params)
      render json: { redirect: participation_path(@participation) }, status: :accepted
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  # DELETE /participations/1
  def destroy
    @participation.destroy
    redirect_to participations_url, notice: "Participation was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_participation
    @participation = Participation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def participation_create_params
    params.require(:participation).permit(:event_id, form_data: {})
  end

  def participation_update_params
    params.require(:participation).permit(form_data: {})
  end
end
