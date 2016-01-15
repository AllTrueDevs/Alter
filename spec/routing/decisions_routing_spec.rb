require "rails_helper"

RSpec.describe DecisionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/decisions").to route_to("notifications#index")
    end

    it "routes to #new" do
      expect(:get => "/decisions/new").to route_to("decisions#new")
    end

    it "routes to #show" do
      expect(:get => "/decisions/1").to route_to("notifications#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/decisions/1/edit").to route_to("decisions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/decisions").to route_to("notifications#create")
    end

    it "routes to #update" do
      expect(:put => "/decisions/1").to route_to("notifications#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/decisions/1").to route_to("notifications#destroy", :id => "1")
    end

  end
end
