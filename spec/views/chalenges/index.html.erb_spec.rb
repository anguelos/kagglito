require 'spec_helper'

describe "chalenges/index.html.erb" do
  before(:each) do
    assign(:chalenges, [
      stub_model(Chalenge,
        :gt => "",
        :gtfileext => "Gtfileext",
        :input => "",
        :input => "Input",
        :name => "Name",
        :Dataset => nil
      ),
      stub_model(Chalenge,
        :gt => "",
        :gtfileext => "Gtfileext",
        :input => "",
        :input => "Input",
        :name => "Name",
        :Dataset => nil
      )
    ])
  end

  it "renders a list of chalenges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Gtfileext".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Input".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
