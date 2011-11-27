require 'spec_helper'

describe "participations/edit.html.erb" do
  before(:each) do
    @participation = assign(:participation, stub_model(Participation,
      :submissionspublic => false,
      :User => nil,
      :Competition => nil
    ))
  end

  it "renders the edit participation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => participations_path(@participation), :method => "post" do
      assert_select "input#participation_submissionspublic", :name => "participation[submissionspublic]"
      assert_select "input#participation_User", :name => "participation[User]"
      assert_select "input#participation_Competition", :name => "participation[Competition]"
    end
  end
end
