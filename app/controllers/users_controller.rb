class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :check_admin, only: %i[ index ]
  before_action :authenticate_user!, except: %i[ new create ]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new --- Managed by Devise
  def new
    redirect_to new_user_registration_path
  end

  # GET /users/1/edit --- Managed by Devise
  def edit
    redirect_to edit_user_registration_path
  end

  # POST /users --- Managed by Devise
  def create
    redirect_to edit_user_registration_path
    # @user = User.new(user_params)

    # if @user.save
    #   redirect_to @user, notice: "User was successfully created."
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /users/1 --- Managed by Devise
  def update
    redirect_to edit_user_registration_path
    # if @user.update(user_params)
    #   redirect_to @user, notice: "User was successfully updated."
    # else
    #   render :edit, status: :unprocessable_entity
    # end
  end

  # DELETE /users/1 --- Managed by Devise
  def destroy
    redirect_to cancel_user_registration_path
    # @user.destroy
    # redirect_to users_url, notice: "User was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :admin)
    end
end
