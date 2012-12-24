require 'spec_helper'

describe "series/index" do
  before(:each) do
    assign(:series, [
      stub_model(Series),
      stub_model(Series)
    ])
  end

  it "renders a list of series" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
