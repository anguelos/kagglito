require 'spec_helper'

describe "competitions/index.html.erb" do
  before(:each) do
    assign(:competitions, [
      stub_model(Competition,
        :name => "Name",
        :description => "MyText",
        :publicscore => false
      ),
      stub_model(Competition,
        :name => "Name",
        :description => "MyText",
        :publicscore => false
      )
    ])
  end

  it "renders a list of competitions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
