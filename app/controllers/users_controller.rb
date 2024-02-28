class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  after_action :verify_authorized, if: -> { Rails.env.development? }

  # GET /users/adminpage
  def adminpage
    authorize User
    @users = User.all.order(created_at: :desc)
    @circles = Circle.all
    @album_count = Album.count(:all)
    @image_count = Album.all.sum { |album| album.images.length }
    @public_image_count = Album.where(public: true).sum { |album| album.images.length }
  end

  # GET /users/1
  def show
    authorize User
  end

  # GET /users/1/edit
  def edit
    authorize User
  end

  # PATCH/PUT /users/1
  def update
    authorize @user
    if @user.update(user_params)
      redirect_to @user, notice: 'Felhasználó sikeresen módosítva.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    authorize @user
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
