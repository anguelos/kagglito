require 'spec_helper'

describe "participations/index.html.erb" do
  before(:each) do
    assign(:participations, [
      stub_model(Participation,
        :submissionspublic => false,
        :User => nil,
        :Competition => nil
      ),
      stub_model(Participation,
        :submissionspublic => false,
        :User => nil,
        :Competition => nil
      )
    ])
  end

  it "renders a list of participations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
