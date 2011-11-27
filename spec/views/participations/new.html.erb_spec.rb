require 'spec_helper'

describe "participations/new.html.erb" do
  before(:each) do
    assign(:participation, stub_model(Participation,
      :submissionspublic => false,
      :User => nil,
      :Competition => nil
    ).as_new_record)
  end

  it "renders new participation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => participations_path, :method => "post" do
      assert_select "input#participation_submissionspublic", :name => "participation[submissionspublic]"
      assert_select "input#participation_User", :name => "participation[User]"
      assert_select "input#participation_Competition", :name => "participation[Competition]"
    end
  end
end
