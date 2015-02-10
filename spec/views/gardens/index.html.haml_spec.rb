require 'rails_helper'

describe "gardens/index" do
  before(:each) do
    controller.stub(:current_user) { nil }
    @owner = FactoryGirl.create(:member)
    @garden = FactoryGirl.create(:garden, :owner => @owner)
    @finished_planting = FactoryGirl.create(:finished_planting, :garden => @garden)
    page = 1
    per_page = 2
    total_entries = 2
    gardens = WillPaginate::Collection.create(page, per_page, total_entries) do |pager|
      pager.replace([@garden, @garden])
    end
    assign(:gardens, gardens)
  end

  it "renders a list of gardens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => @garden.name, :count => 2
    assert_select "tr>td>a", :text => @garden.location, :count => 2
    assert_select "tr>td", :text => pluralize(@garden.area, @garden.area_unit), :count => 2
  end

  it "does not show finished plantings" do
    render
    expect(rendered).to_not have_content(@finished_planting.crop_name)
  end
end
