require 'spec_helper'

describe "datasets/index.html.erb" do
  before(:each) do
    assign(:datasets, [
      stub_model(Dataset,
        :name => "Name",
        :gtpublic => false,
        :inputpublic => false,
        :description => "MyText"
      ),
      stub_model(Dataset,
        :name => "Name",
        :gtpublic => false,
        :inputpublic => false,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of datasets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
