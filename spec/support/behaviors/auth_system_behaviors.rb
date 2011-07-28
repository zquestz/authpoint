shared_examples_for "an auth system" do
  describe "logged in" do
    before do
      @user = Factory(:user)
      subject.setup_session(@user.id)
    end

    it "should have current_user" do
      subject.current_user.id.should == @user.id
    end

    it "should be logged in" do
      subject.logged_in?.should be_true
    end
  end

  describe "logged out" do
    it "should not have current_user" do
      subject.current_user.should be_blank
    end

    it "should be logged out" do
      subject.logged_in?.should be_false
    end
  end
end