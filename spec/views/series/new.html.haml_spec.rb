require 'spec_helper'

describe "series/new" do
  before(:each) do
    assign(:series, stub_model(Series).as_new_record)
  end

  it "renders new series form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => series_index_path, :method => "post" do
    end
  end
end
