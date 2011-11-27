require 'spec_helper'

describe "submissions/new.html.erb" do
  before(:each) do
    assign(:submission, stub_model(Submission,
      :response => "",
      :responsefileext => "MyString",
      :score => 1.5,
      :Chalenge => nil,
      :participation => nil
    ).as_new_record)
  end

  it "renders new submission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => submissions_path, :method => "post" do
      assert_select "input#submission_response", :name => "submission[response]"
      assert_select "input#submission_responsefileext", :name => "submission[responsefileext]"
      assert_select "input#submission_score", :name => "submission[score]"
      assert_select "input#submission_Chalenge", :name => "submission[Chalenge]"
      assert_select "input#submission_participation", :name => "submission[participation]"
    end
  end
end
