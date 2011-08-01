class UsersController < ApplicationController
  before_filter :require_login, :verify_user
  
  # GET /users/1
  # GET /users/1.json
  def show    
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => t(:user_updated, :scope => [:flash])) }
        format.json  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    reset_session
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(root_path) }
      format.json  { head :ok }
    end
  end
  
  protected
  
  def verify_user
    @user = User.find(params[:id])
    unless current_user == @user
      flash[:error] = t(:access_denied, :scope => [:flash])
      redirect_back_or_default(root_path)
    end
  end
end
