class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  # Please note, we're using default_scope with this model's static_id
  # Info: https://guides.rubyonrails.org/active_record_querying.html#applying-a-default-scope
  before_action :check_admin, except: %i[ show index about ]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      if @post.about?
        redirect_to about_path, notice: "Post was successfully updated."
      else
        redirect_to @post, notice: "Post was successfully updated."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  # GET /about
  def about
    begin
      @post = Post.unscoped.find_by! static_id: :about
    rescue ActiveRecord::RecordNotFound
      @post = Post.create! static_id: :about, title: 'Rólunk oldal tartalma', short_description: '[Nem szükséges kitölteni]'
      redirect_to edit_post_url(@post)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.unscoped.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :short_description, :formatted_document)
    end
end
