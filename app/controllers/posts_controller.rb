class PostsController < ApplicationController
  before_filter :require_login
  before_filter :verify_user, :only => [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    if params[:tag].blank?
      @posts = current_user.posts.paginate(:page => params[:page])
    else
      @posts = current_user.posts.tagged_with(params[:tag]).paginate(:page => params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { 
          flash[:notice] = t(:post_created, :scope => [:flash])
          redirect_back_or_default(post_path(@post))
        }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { 
          flash[:notice] = t(:post_updated, :scope => [:flash])
          redirect_back_or_default(post_path(@post))
        }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
  
  protected
  
  def verify_user
    @post = Post.find(params[:id], :include => :user)
    
    unless current_user == @post.user
      flash[:error] = t(:access_denied, :scope => [:flash])
      redirect_back_or_default(root_path)
    end
  end
end
