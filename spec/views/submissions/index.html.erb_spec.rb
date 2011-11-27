require 'spec_helper'

describe "submissions/index.html.erb" do
  before(:each) do
    assign(:submissions, [
      stub_model(Submission,
        :response => "",
        :responsefileext => "Responsefileext",
        :score => 1.5,
        :Chalenge => nil,
        :participation => nil
      ),
      stub_model(Submission,
        :response => "",
        :responsefileext => "Responsefileext",
        :score => 1.5,
        :Chalenge => nil,
        :participation => nil
      )
    ])
  end

  it "renders a list of submissions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Responsefileext".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
