class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    posts = Post.original.published.recent
    @posts_for_react = posts.map{ |p| p.to_h.merge(p.subscription_hash(current_user)) }
  end

  def show
    @post           = Post.includes(:comments).find_by_slug(params[:id])
    @comment        = Comment.new
    @post_for_react = @post.to_h.merge(@post.subscription_hash(current_user))
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, :published, :slug, :title, :author_id, :top_image, :image_1, :image_2, :tag_names)
    end
end
