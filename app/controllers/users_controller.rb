class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :login_required
  before_action :site_admin_required, only: %i[adminpage edit update destroy]

  # GET /users/adminpage
  def adminpage
    @users = User.all.order(created_at: :desc)
    @album_count = Album.count(:all)
    @image_count = Album.all.sum { |album| album.images.length }
    @public_image_count = Album.all.sum { |album| album.images.length if album.public? }
  end

  # GET /users/1
  def show; end

  # GET /users/1/edit
  def edit; end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Felhasználó sikeresen módosítva.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to albums_url, notice: 'Felhasználó sikeresen törölve.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:site_admin)
  end
end
