require 'spec_helper'

describe "evaluators/edit.html.erb" do
  before(:each) do
    @evaluator = assign(:evaluator, stub_model(Evaluator,
      :name => "MyString",
      :description => "MyText",
      :minvalue => 1.5,
      :maxvalue => 1.5,
      :src => "",
      :User => nil
    ))
  end

  it "renders the edit evaluator form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => evaluators_path(@evaluator), :method => "post" do
      assert_select "input#evaluator_name", :name => "evaluator[name]"
      assert_select "textarea#evaluator_description", :name => "evaluator[description]"
      assert_select "input#evaluator_minvalue", :name => "evaluator[minvalue]"
      assert_select "input#evaluator_maxvalue", :name => "evaluator[maxvalue]"
      assert_select "input#evaluator_src", :name => "evaluator[src]"
      assert_select "input#evaluator_User", :name => "evaluator[User]"
    end
  end
end
