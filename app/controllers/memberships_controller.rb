class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[destroy]
  before_action :admin_required, only: %i[destroy]

  # POST /memberships
  def create
    @membership = Membership.new(membership_params)

    if @circle.save
      redirect_to @circle, notice: 'Tagság sikeresen létrehozva.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /circles/1
  def destroy
    @membership.destroy
    redirect_to circles_url, notice: 'Tagság sikeresen törölve.'
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
    unless logged_in_as_admin_of?(@membership.circle)
      redirect_to @album, notice: 'Nincs jogosultságod az funkcióhoz!'
    end
  end
end
