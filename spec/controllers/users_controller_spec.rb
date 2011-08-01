require 'spec_helper'

describe UsersController do
  render_views
  
  before do
    @user = Factory(:user)
    @user2 = Factory(:user)
  end
  
  describe "GET show" do
    context "logged in as user" do
      it "assigns the requested user as @user" do
        session[:user_id] = @user.id
        get :show, :id => @user.id.to_s
        assigns(:user).should eq(@user)
        assigns(:user).should eq(subject.current_user)
        response.should be_success
      end
    end

    context "logged in as another user" do
      it "redirects and says access denied" do
        session[:user_id] = @user2.id
        get :show, :id => @user.id.to_s
        assigns(:user).should eq(@user)
        assigns(:user).should_not eq(subject.current_user)
        response.should be_redirect
      end
    end
    
    context "logged out" do
      it "redirects to login page" do
        get :show, :id => @user.id.to_s
        assigns(:user).should be_nil
        response.should be_success
      end
    end
  end

  describe "GET edit" do
    context "logged in as user" do
      it "assigns the requested user as @user" do
        session[:user_id] = @user.id
        get :edit, :id => @user.id.to_s
        assigns(:user).should eq(@user)
        assigns(:user).should eq(subject.current_user)
        response.should be_success
      end
    end
    
    context "logged in as another user" do
      it "redirects and says access denied" do
        session[:user_id] = @user2.id
        get :edit, :id => @user.id.to_s
        assigns(:user).should eq(@user)
        assigns(:user).should_not eq(subject.current_user)
        response.should be_redirect
      end
    end
    
    context "logged out" do
      it "redirects to login page" do
        get :edit, :id => @user.id.to_s
        assigns(:user).should be_nil
        response.should be_success
      end
    end
  end
  
  describe "PUT update" do
    before do
      @valid_attributes = {'name' => @user.name}
      @invalid_attributes = {'name' => ''}
    end
    
    context "logged in as user" do
      before do
        session[:user_id] = @user.id
      end
      
      describe "with valid params" do
        it "updates the requested user" do
          User.any_instance.should_receive(:update_attributes).with(@valid_attributes)
          put :update, :id => @user.id, :user => @valid_attributes
        end
  
        it "assigns the requested user as @user" do
          put :update, :id => @user.id, :user => @valid_attributes
          assigns(:user).should eq(@user)
          assigns(:user).should eq(subject.current_user)
        end
  
        it "redirects to the user" do
          put :update, :id => @user.id, :user => @valid_attributes
          response.should redirect_to(@user)
        end
      end
  
      describe "with invalid params" do
        it "assigns the user as @user" do
          put :update, :id => @user.id.to_s, :user => @invalid_attributes
          assigns(:user).should eq(@user)
        end
  
        it "re-renders the 'edit' template" do
          put :update, :id => @user.id.to_s, :user => @invalid_attributes
          response.should render_template('edit')
        end
      end
    end
    
    context "logged in as another user" do
      it "redirects and says access denied" do
        session[:user_id] = @user2.id
        put :update, :id => @user.id.to_s, :user => @valid_attributes
        assigns(:user).should eq(@user)
        assigns(:user).should_not eq(subject.current_user)
        response.should be_redirect
      end
    end
    
    context "logged out" do
      it "redirects to login page" do
        put :update, :id => @user.id.to_s
        assigns(:user).should be_nil
        response.should be_success
      end
    end
  end
  
  describe "DELETE destroy" do
    context "logged in as user" do
      before do
        session[:user_id] = @user.id
      end
      
      it "destroys the requested user" do
        expect {
          delete :destroy, :id => @user.id.to_s
        }.to change(User, :count).by(-1)
      end
      
      it "assigns the requested user as @user" do
        delete :destroy, :id => @user.id.to_s
        assigns(:user).should eq(@user)
      end
      
      it "redirects to the root path" do
        delete :destroy, :id => @user.id.to_s
        response.should redirect_to(root_path)
      end
    end
    
    context "logged in as another user" do
      before do
        session[:user_id] = @user2.id
      end
      
      it "does not destroy the requested user" do
        expect {
          delete :destroy, :id => @user.id.to_s
        }.to change(User, :count).by(0)
      end
      
      it "assigns the requested user as @user" do
        delete :destroy, :id => @user.id.to_s
        assigns(:user).should eq(@user)
      end
      
      it "redirects to the root path" do
        delete :destroy, :id => @user.id.to_s
        response.should redirect_to(root_path)
      end
    end
    
    context "logged out" do
      it "redirects to login page" do
        delete :destroy, :id => @user.id.to_s
        assigns(:user).should be_nil
        response.should be_success
      end
    end
  end

end
