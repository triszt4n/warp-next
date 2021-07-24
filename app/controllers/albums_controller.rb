class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy delete_image add_image ]
  before_action :check_admin, except: %i[ show index ]
  attr_accessor :render_target

  # GET /albums
  def index
    @albums = Album.all
  end

  # GET /albums/1
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  def create
    @render_target = :new

    @album = Album.new(album_params)
    @album.images = params[:album][:images]

    if @album.save
      redirect_to @album, notice: "Album was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  def update
    @render_target = :edit

    if @album.update(album_params)
      redirect_to @album, notice: "Album was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
    redirect_to albums_url, notice: "Album was successfully destroyed."
  end

  # DELETE one image of the album
  def delete_image
    @image = ActiveStorage::Attachment.find(params[:image_id])
    @image.purge
    redirect_to @album
  end

  # POST add image(s) to the album
  def add_image
    images = params[:images]
    @album.images.attach(images) if images.present?
    
    redirect_to @album, notice: "Album was successfully updated."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:title, :date, :short_desc)
    end
end
