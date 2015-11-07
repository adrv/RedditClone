class PostsController < ApplicationController

  def index
    @posts = Post.where(parent_id: nil)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if @post.reply?
        notify_owner_for_new_reply(@post)
      end
      redirect_to posts_path, notice: 'Post successfully created'
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to posts_path
  end

  def destroy
    @post = Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  def vote
    post, vote = Post.find(params[:id]), params[:vote]
    post.vote_by(voter: current_user, vote: vote)
    render json: { votes: post.get_likes.size - post.get_dislikes.size }
  end


  private

  def notify_owner_for_new_reply(post)
    channel_id = post.parent.user.encrypted_id
    PrivatePub.publish_to "/messages/new/#{channel_id}", msg: I18n.t('new_reply'), link: post.link
  end

  def post_params
    params.require(:post).permit(:content, :parent_id, :user_id)
  end
end
