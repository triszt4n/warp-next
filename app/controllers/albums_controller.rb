class AlbumsController < ApplicationController
  before_action :set_album, only: %i[edit update destroy delete_image add_image]
  before_action :login_required
  before_action :admin_or_owner_required, only: %i[edit update destroy]
  before_action :admin_or_owner_or_shared_required, only: %i[delete_image add_image]
  attr_accessor :render_target

  after_action :analyze_album, only: %i[create add_image]

  # GET /albums
  def index
    @albums = Album.all.order(created_at: :desc)
    @title = 'Minden album'
  end

  # GET /albums/myalbums
  def myalbums
    @albums = Album.where(user: current_user).order(created_at: :desc)
    @title = 'Albumaim'
    render :index
  end

  # GET /albums/1
  def show
    @album = Album.includes(:images_attachments).find(params[:id])
  end

  # GET /albums/new
  def new
    @album = Album.new
    @circles = current_user.circles

    if @circles.empty?
      redirect_to circles_path, notice: 'Nincs körtagsága, nem hozhat létre kört!'
    end
  end

  # GET /albums/1/edit
  def edit; end

  # POST /albums
  def create
    @render_target = :new

    @album = Album.new(album_params)
    @album.images = params[:album][:images]
    @album.user = current_user

    if @album.save
      redirect_to @album, notice: 'Album sikeresen létrehozva.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  def update
    @render_target = :edit

    if @album.update(album_params)
      redirect_to @album, notice: 'Album sikeresen módosítva.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
    redirect_to albums_url, notice: 'Album sikeresen törölve.'
  end

  # GET /albums/1/image?image_id=1
  def image
    render json: {
      url: url_for(ActiveStorage::Attachment.find(params[:image_id])),
      filename: ActiveStorage::Attachment.find(params[:image_id]).blob.filename
    }
  end

  # DELETE one image of the album
  def delete_image
    image = ActiveStorage::Attachment.find(params[:image_id])
    image.purge
    redirect_to @album
  end

  # POST add image(s) to the album
  def add_image
    images = params[:images]
    @album.images.attach(images) if images.present?

    redirect_to @album, notice: 'Album sikeresen módosítva.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.find(params[:id])
  end

  # Analyze all the images for their width and height
  def analyze_album
    @album.images.each { |i| i.analyze unless i.analyzed? }
  end

  # Allow only owner or admin
  def admin_or_owner_required
    unless current_user == @album.user || logged_in_as_site_admin? || logged_in_as_admin_of?(@album.circle)
      redirect_to @album,
                  notice: 'Nincs jogosultságod az funkcióhoz!'
    end
  end

  # Allow for shared
  def admin_or_owner_or_shared_required
    unless current_user == @album.user || logged_in_as_site_admin? || logged_in_as_admin_of?(@album.circle) || @album.shared?
      redirect_to @album, notice: 'Nincs jogosultságod az funkcióhoz!'
    end
  end

  # Only allow a list of trusted parameters through.
  def album_params
    params.require(:album).permit(:title, :desc, :shared, :public, :tag, :circle_id)
  end
end
