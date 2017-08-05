class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy, :add_comment, :update_comment]
  before_filter :sanitize_comment_params, only: :add_comment

  respond_to :js, only: [:add_comment, :update_comment]

  def index
    posts = Post.original.published.recent
    @posts_for_react = posts.map{ |p| p.to_h.merge(p.subscription_hash(current_user)) }
  end

  def show
    params[:id] == 'root' ? @post = Post.first : set_post
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

  def add_comment
    @comment = @post.comments.build(comment_params.merge(slug: "comment-#{Time.now.to_i}", published: true))
    @comment.save
    @new_comments_count = @post.comments.published.count
  end

  def update_comment
    @comment = Post.find(params[:comment_id])
    @comment.update(published: false)
    @new_comments_count = @post.comments.published.count
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

    def comment_params
      params.require(:comment).permit(:body, :author_id)
    end

    def post_params
      params.require(:post).permit(:body, :published, :slug, :author_id, :top_image, :image_1, :image_2, :tag_names)
    end

    def sanitize_comment_params
      params[:comment][:author_id] = params[:comment][:author_id].to_i
    end
end
