require 'spec_helper'

describe "chalenges/new.html.erb" do
  before(:each) do
    assign(:chalenge, stub_model(Chalenge,
      :gt => "",
      :gtfileext => "MyString",
      :input => "",
      :input => "MyString",
      :name => "MyString",
      :Dataset => nil
    ).as_new_record)
  end

  it "renders new chalenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => chalenges_path, :method => "post" do
      assert_select "input#chalenge_gt", :name => "chalenge[gt]"
      assert_select "input#chalenge_gtfileext", :name => "chalenge[gtfileext]"
      assert_select "input#chalenge_input", :name => "chalenge[input]"
      assert_select "input#chalenge_input", :name => "chalenge[input]"
      assert_select "input#chalenge_name", :name => "chalenge[name]"
      assert_select "input#chalenge_Dataset", :name => "chalenge[Dataset]"
    end
  end
end
