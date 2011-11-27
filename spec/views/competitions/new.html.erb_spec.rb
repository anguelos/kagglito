require 'spec_helper'

describe "competitions/new.html.erb" do
  before(:each) do
    assign(:competition, stub_model(Competition,
      :name => "MyString",
      :description => "MyText",
      :publicscore => false
    ).as_new_record)
  end

  it "renders new competition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => competitions_path, :method => "post" do
      assert_select "input#competition_name", :name => "competition[name]"
      assert_select "textarea#competition_description", :name => "competition[description]"
      assert_select "input#competition_publicscore", :name => "competition[publicscore]"
    end
  end
end
