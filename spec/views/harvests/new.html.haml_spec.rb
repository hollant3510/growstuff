require 'rails_helper'

describe "harvests/new" do
  before do
    assign(:harvest, FactoryBot.create(:harvest))
    render
  end

  it "renders new harvest form" do
    assert_select "form", action: harvests_path, method: "post" do
      assert_select "input#crop", class: "ui-autocomplete-input"
      assert_select "input#harvest_crop_id", name: "harvest[crop_id]"
      assert_select "select#harvest_plant_part_id", name: "harvest[plant_part_id]"
      # some browsers interpret <input type="number"> without a step as "integer"
      assert_select "input#harvest_quantity[step=any]", name: "harvest[quantity]"
      assert_select "input#harvest_weight_quantity[step=any]", name: "harvest[quantity]"
      assert_select "select#harvest_unit", name: "harvest[unit]"
      assert_select "select#harvest_weight_unit", name: "harvest[unit]"
      assert_select "textarea#harvest_description", name: "harvest[description]"
    end
  end
end
