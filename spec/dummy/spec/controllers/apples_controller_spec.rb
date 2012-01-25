require 'spec_helper'

# =================================================
# = Note - only HTML and JSON are tested here... == 
# 
# The HTML blocks in the DRY controllers are 
# custom responders. JSON and any other formats will
# respond to the format in the default manner. So I
# figured it was fine to only test these two MIMEs
# Read here for more info 
# http://api.rubyonrails.org/classes/ActionController/Responder.html
# =================================================
describe ApplesController do

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

  describe :index, "as JSON" do

    def do_get
      get :index, format: :json
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

    it 'responds with apples as JSON' do
      do_get
      response.body.should eql(Apple.all.to_json)
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

  describe :new, "as JSON" do

    def do_get
      get :new, format: :json
    end

    it "responds with success" do
      do_get
      response.should be_success
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
      flash[:notice].should eql('Apple successfully created!')
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

    it "renders the new template" do
      do_post
      response.should render_template(:new)
    end

  end

  describe :create, "as JSON with valid attributes" do

    def do_post
      post :create, apple: {'name' => 'steve'}, format: :json
    end

    it "responds with 201 created" do
      do_post
      response.status.should eql(201)
    end

    it "should respond with the new resource as JSON" do
      do_post
      response.body.should eql(Apple.last.to_json)
    end

  end


  describe :create, "as JSON with invalid attributes" do

    before do
      @apple = Apple.new
      @apple.errors.add(:name, "wasn't valid")
      @apple.errors.add(:age, "was too young")      
      @apple.expects(:save).returns(false)
      Apple.expects(:new).with({'name' => 'steve'}).returns(@apple)
    end

    def do_post
      post :create, apple: {'name' => 'steve'}, format: :json
    end

    it "should respond with the error messages as an array" do
      do_post
      errors = {'name' => ["wasn't valid"], 'age' => ["was too young"]}.to_json
      response.body.should eql(errors)
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

  describe :show, "as JSON" do

    def do_get
      get :show, id: "1", format: :json
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

    it "responds with the apple as JSON" do
      @apple = Apple.new(name: "Joe")
      Apple.expects(:find).with('1').returns(@apple)
      do_get
      response.body.should eql(@apple.to_json)
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

  describe :edit, "as JSON" do

    def do_get
      get :edit, id: "1", format: :json
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

    it "responds with the apple as JSON" do
      @apple = Apple.new(name: "Joe")
      Apple.expects(:find).with('1').returns(@apple)
      do_get
      response.body.should eql(@apple.to_json)
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
      flash[:notice].should eql('Apple successfully updated!')
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

  describe :update, "as JSON with valid attributes" do

    before do
      @apple = Apple.first || Apple.create      
      Apple.expects(:find).with(@apple.id.to_s).returns(@apple)
    end

    def do_put
      put :update, id: '1', apple: {'name' =>  'steve'}, format: :json
    end

    it "should be success" do
      do_put
      response.should be_success
    end

  end

  describe :update, "as JSON with invalid attributes" do

    before do
      @apple = Apple.new      
      Apple.expects(:find).with('1').returns(@apple)
      @apple.errors.add(:name, "too long")
      @apple.errors.add(:body, "too fat")
    end

    def do_put
      put :update, id: '1', apple: {'name' =>  'steve'}, format: :json
    end

    it "renders the errors as JSON" do
      do_put
      @errors = {name: ["too long"], body: ["too fat"]}  
      response.body.should eql(@errors.to_json)
    end

  end
  
  describe :destroy, "as HTML" do

    before do
      @apple = Apple.new      
      Apple.expects(:find).with('1').returns(@apple)
      @apple.expects(:destroy).returns(@apple)
    end

    def do_delete
      delete :destroy, id: '1'
    end

    it "redirects to apples_url" do
      do_delete
      response.should redirect_to(apples_url)
    end

    it "sets the default flash notice" do
      do_delete
      flash[:notice].should eql("Apple successfully destroyed!")
    end

  end

  describe :destroy, "as JSON" do

    before do
      @apple = Apple.create!
    end

    def do_delete
      delete :destroy, id: @apple.id, format: :json
    end

    it "responds with success" do
      do_delete
      response.should be_success
    end

  end
end