require "test_helper"

class ExperimentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @experiment = experiments(:one)
  end

  test "should get index" do
    get experiments_url
    assert_response :success
  end

  test "should show experiment" do
    get experiment_url(@experiment)
    assert_response :success
  end

end
