require "spec_helper"

describe ChalengesController do
  describe "routing" do

    it "routes to #index" do
      get("/chalenges").should route_to("chalenges#index")
    end

    it "routes to #new" do
      get("/chalenges/new").should route_to("chalenges#new")
    end

    it "routes to #show" do
      get("/chalenges/1").should route_to("chalenges#show", :id => "1")
    end

    it "routes to #edit" do
      get("/chalenges/1/edit").should route_to("chalenges#edit", :id => "1")
    end

    it "routes to #create" do
      post("/chalenges").should route_to("chalenges#create")
    end

    it "routes to #update" do
      put("/chalenges/1").should route_to("chalenges#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/chalenges/1").should route_to("chalenges#destroy", :id => "1")
    end

  end
end
