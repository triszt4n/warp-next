class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[destroy accept demote promote]
  before_action :admin_required, only: %i[destroy accept demote promote]

  # POST /memberships
  def create
    @membership = Membership.new(membership_params)

    if @membership.save
      redirect_to circles_path, notice: 'Tagság sikeresen létrehozva.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /memberships/1
  def destroy
    circle = @membership.circle
    @membership.destroy
    redirect_to details_circle_path(circle), notice: 'Tagság sikeresen törölve.'
  end

  # POST /memberships/1/accept
  def accept
    @membership.accepted = true

    if @membership.save
      redirect_to details_circle_path(@membership.circle), notice: 'Tagság sikeresen elfogadva.'
    else
      redirect_to details_circle_path(@membership.circle), notice: 'Tagság elfogadása sikertelen!'
    end
  end

  # POST /memberships/1/promote
  def promote
    @membership.admin = true

    if @membership.save
      redirect_to details_circle_path(@membership.circle), notice: 'Tag sikeresen köradmin lett.'
    else
      redirect_to details_circle_path(@membership.circle), notice: 'Tagság módosítása sikertelen!'
    end
  end

  # POST /memberships/1/demote
  def demote
    @membership.admin = false

    if @membership.save
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

  # Allow for admin of circle
  def admin_required
    unless logged_in_as_site_admin? || logged_in_as_admin_of?(@membership.circle)
      redirect_to @membership, notice: 'Nincs jogosultságod az funkcióhoz!'
    end
  end
end
