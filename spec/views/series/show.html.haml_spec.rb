require 'spec_helper'

describe "series/show" do
  before(:each) do
    @series = assign(:series, stub_model(Series))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
