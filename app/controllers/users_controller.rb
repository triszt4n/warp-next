class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :login_required
  before_action :admin_required, only: %i[ adminpage edit update destroy ]

  # GET /users/adminpage
  def adminpage
    @authorized_users = User.where(authorized: true).order(created_at: :desc)
    @unauthorized_users = User.where(authorized: false).order(created_at: :desc)
    @album_count = Album.count(:all)
    @image_count = Album.all.sum { |album| album.images.length }
    @public_image_count = Album.all.sum { |album| album.images.length if album.public? }
  end

  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Felhasználó sikeres módosítva."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to albums_url, notice: "Felhasználó sikeres törölve."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:force_authorized, :admin, :authorized)
    end
end
