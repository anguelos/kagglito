require "spec_helper"

describe EvaluatorsController do
  describe "routing" do

    it "routes to #index" do
      get("/evaluators").should route_to("evaluators#index")
    end

    it "routes to #new" do
      get("/evaluators/new").should route_to("evaluators#new")
    end

    it "routes to #show" do
      get("/evaluators/1").should route_to("evaluators#show", :id => "1")
    end

    it "routes to #edit" do
      get("/evaluators/1/edit").should route_to("evaluators#edit", :id => "1")
    end

    it "routes to #create" do
      post("/evaluators").should route_to("evaluators#create")
    end

    it "routes to #update" do
      put("/evaluators/1").should route_to("evaluators#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/evaluators/1").should route_to("evaluators#destroy", :id => "1")
    end

  end
end
