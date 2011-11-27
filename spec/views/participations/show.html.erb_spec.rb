require 'spec_helper'

describe "participations/show.html.erb" do
  before(:each) do
    @participation = assign(:participation, stub_model(Participation,
      :submissionspublic => false,
      :User => nil,
      :Competition => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
