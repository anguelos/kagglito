require 'spec_helper'

describe "chalenges/show.html.erb" do
  before(:each) do
    @chalenge = assign(:chalenge, stub_model(Chalenge,
      :gt => "",
      :gtfileext => "Gtfileext",
      :input => "",
      :input => "Input",
      :name => "Name",
      :Dataset => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Gtfileext/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Input/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
