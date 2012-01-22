require 'spec_helper'

describe MonkiesController do

  describe :index, "as HTML" do

    def do_get
      get :index
    end

    it "responds with 200 success" do
      do_get
      response.should be_success
    end

    it "sets apples to Apples.all by default" do
      Apple.expects(:all).returns(@apples = [])
      do_get
      assigns(:apples).should eql(@apples)
    end

  end

  describe :new, "as HTML" do

    def do_get
      get :new
    end

    it "responds with 200 success" do
      do_get
      response.should be_success
    end

    it "sets apple to Apples.new by default" do
      Apple.expects(:new).with(nil).returns(@apple = [])
      do_get
      assigns(:apple).should eql(@apple)
    end

  end

  describe :create, "as HTML with valid attributes" do

    before do
      @apple = Apple.new({'name' => "steve"})
      Apple.expects(:new).with({'name' => "steve"}).returns(@apple)
    end

    def do_post
      post :create, apple: {name: "steve"}
    end

    it "redirects to the apple page" do
      do_post
      response.should redirect_to(apple_url(id: @apple.id))
    end

    it "sets the flash notice to 'Successfully created Apple'" do
      do_post
      flash[:notice].should eql('Successfully created Apple')
    end

  end

  describe :create, "as HTML with invalid attributes" do

    before do
      @apple = []
      Apple.expects(:new).with({'name' => "steve"}).returns(@apple)
      @apple.expects(:save).returns(false)
    end

    def do_post
      post :create, apple: {'name' => 'steve'}
    end

    it "rednders the new template" do
      do_post
      response.should render_template(:new)
    end

  end

  describe :show, "as HTML" do

    def do_get
      get :show, id: "1"
    end

    it "responds with 200 success" do
      do_get
      response.should be_success
    end

    it "sets apple to Apples found by the :id param" do
      Apple.expects(:find).with("1").returns(@apple = [])
      do_get
      assigns(:apple).should eql(@apple)
    end

  end
  
  describe :edit, "as HTML" do

    def do_get
      get :edit, id: "1"
    end

    it "responds with 200 success" do
      do_get
      response.should be_success
    end

    it "sets apple to Apples found by the :id param" do
      Apple.expects(:find).with("1").returns(@apple = [])
      do_get
      assigns(:apple).should eql(@apple)
    end

  end
  
  
  describe :update, "as HTML with valid attributes" do

    before do
      @apple = Apple.first || Apple.create      
      Apple.expects(:find).with(@apple.id.to_s).returns(@apple)
      @apple.expects(:update_attributes).with({'name' => 'steve'}).returns(true)
    end

    def do_put
      put :update, id: '1', apple: {'name' =>  'steve'}
    end

    it "redirects to the apple page" do
      do_put
      response.should redirect_to(apple_url(id: 1))
    end

    it "sets the flash notice to 'Successfully updated Apple'" do
      do_put
      flash[:notice].should eql('Successfully updated Apple')
    end

  end

  describe :update, "as HTML with invalid attributes" do

    before do
      @apple = Apple.new      
      Apple.expects(:find).with('1').returns(@apple)
      @apple.expects(:update_attributes).with({'name' => 'steve'}).returns(false)
    end

    def do_put
      put :update, id: '1', apple: {'name' =>  'steve'}
    end

    it "renders to the edit page" do
      do_put
      response.should render_template(:edit)
    end

  end

end