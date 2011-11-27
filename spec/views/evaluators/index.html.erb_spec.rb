require 'spec_helper'

describe "evaluators/index.html.erb" do
  before(:each) do
    assign(:evaluators, [
      stub_model(Evaluator,
        :name => "Name",
        :description => "MyText",
        :minvalue => 1.5,
        :maxvalue => 1.5,
        :src => "",
        :User => nil
      ),
      stub_model(Evaluator,
        :name => "Name",
        :description => "MyText",
        :minvalue => 1.5,
        :maxvalue => 1.5,
        :src => "",
        :User => nil
      )
    ])
  end

  it "renders a list of evaluators" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
