require 'spec_helper'

describe "datasets/new.html.erb" do
  before(:each) do
    assign(:dataset, stub_model(Dataset,
      :name => "MyString",
      :gtpublic => false,
      :inputpublic => false,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new dataset form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => datasets_path, :method => "post" do
      assert_select "input#dataset_name", :name => "dataset[name]"
      assert_select "input#dataset_gtpublic", :name => "dataset[gtpublic]"
      assert_select "input#dataset_inputpublic", :name => "dataset[inputpublic]"
      assert_select "textarea#dataset_description", :name => "dataset[description]"
    end
  end
end
