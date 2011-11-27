require 'spec_helper'

describe "evaluators/new.html.erb" do
  before(:each) do
    assign(:evaluator, stub_model(Evaluator,
      :name => "MyString",
      :description => "MyText",
      :minvalue => 1.5,
      :maxvalue => 1.5,
      :src => "",
      :User => nil
    ).as_new_record)
  end

  it "renders new evaluator form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => evaluators_path, :method => "post" do
      assert_select "input#evaluator_name", :name => "evaluator[name]"
      assert_select "textarea#evaluator_description", :name => "evaluator[description]"
      assert_select "input#evaluator_minvalue", :name => "evaluator[minvalue]"
      assert_select "input#evaluator_maxvalue", :name => "evaluator[maxvalue]"
      assert_select "input#evaluator_src", :name => "evaluator[src]"
      assert_select "input#evaluator_User", :name => "evaluator[User]"
    end
  end
end
