require 'spec_helper'

describe "series/edit" do
  before(:each) do
    @series = assign(:series, stub_model(Series))
  end

  it "renders the edit series form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => series_index_path(@series), :method => "post" do
    end
  end
end
