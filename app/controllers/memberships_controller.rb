class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[destroy accept demote promote]
  after_action :verify_authorized, if: -> { Rails.env.development? }
  # POST /memberships
  def create
    authorize Membership
    @membership = Membership.new(membership_params)

    if @membership.save
      redirect_to circles_path, notice: 'Tagság sikeresen létrehozva.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /memberships/1
  def destroy
    authorize @membership
    circle = @membership.circle
    @membership.destroy
    redirect_to details_circle_path(circle), notice: 'Tagság sikeresen törölve.'
  end

  # POST /memberships/1/accept
  def accept
    authorize @membership

    if @membership.update(accepted: true)
      redirect_to details_circle_path(@membership.circle), notice: 'Tagság sikeresen elfogadva.'
    else
      redirect_to details_circle_path(@membership.circle), notice: 'Tagság elfogadása sikertelen!'
    end
  end

  # POST /memberships/1/promote
  def promote
    authorize @membership

    if @membership.update(admin: true)
      redirect_to details_circle_path(@membership.circle), notice: 'Tag sikeresen köradmin lett.'
    else
      redirect_to details_circle_path(@membership.circle), notice: 'Tagság módosítása sikertelen!'
    end
  end

  # POST /memberships/1/demote
  def demote
    authorize @membership

    if @membership.update(admin: false)
      redirect_to details_circle_path(@membership.circle), notice: 'Tag köradminsága sikeresen megszüntetve.'
    else
      redirect_to details_circle_path(@membership.circle), notice: 'Tagság módosítása sikertelen!'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def membership_params
    params.require(:membership).permit(:circle_id, :user_id)
  end
end
