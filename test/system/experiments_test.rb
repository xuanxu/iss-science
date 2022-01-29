require "application_system_test_case"

class ExperimentsTest < ApplicationSystemTestCase
  setup do
    @experiment = experiments(:one)
  end

  test "visiting the index" do
    visit experiments_url
    assert_selector "h1", text: "Experiments"
  end

  test "should create experiment" do
    visit experiments_url
    click_on "New experiment"

    click_on "Create Experiment"

    assert_text "Experiment was successfully created"
    click_on "Back"
  end

  test "should update Experiment" do
    visit experiment_url(@experiment)
    click_on "Edit this experiment", match: :first

    click_on "Update Experiment"

    assert_text "Experiment was successfully updated"
    click_on "Back"
  end

  test "should destroy Experiment" do
    visit experiment_url(@experiment)
    click_on "Destroy this experiment", match: :first

    assert_text "Experiment was successfully destroyed"
  end
end
