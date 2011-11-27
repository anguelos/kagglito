require 'spec_helper'

describe "submissions/show.html.erb" do
  before(:each) do
    @submission = assign(:submission, stub_model(Submission,
      :response => "",
      :responsefileext => "Responsefileext",
      :score => 1.5,
      :Chalenge => nil,
      :participation => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Responsefileext/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
