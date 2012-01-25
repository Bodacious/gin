require 'spec_helper'

# =================================================
# = Note - the only things that are tested in this 
# spec are the changes to the default behaviour
# Default behaviour should be tested in the 
# monkiesController spec
# =================================================
describe MonkiesController do

  describe :create, "as HTML with valid attributes" do

    before do
      @apple = Apple.new({'name' => "steve"})
      Apple.expects(:new).with({'name' => "steve"}).returns(@apple)
    end

    def do_post
      post :create, apple: {name: "steve"}
    end

    it "redirects to the custom redirect url" do
      do_post
      response.should redirect_to(monkies_url)
    end

    it "sets the custom flash notice" do
      do_post
      flash[:notice].should eql("Monky successfully created - yay!")
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

    it "redirects to the custom redirect url" do
      do_put
      response.should redirect_to(monky_url(@apple))
    end

    it "sets the custom flash notice" do
      do_put
      flash[:notice].should eql("Monky #{@apple.id} successfully updated")
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

    it "redirects to monkies_url" do
      do_delete
      response.should redirect_to('http://nooooooooooooooo.com/')
    end    

  end

end