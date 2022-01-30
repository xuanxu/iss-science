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

  test "should update experiment" do
    patch experiment_url(@experiment), params: { experiment: { short_name: "APEX-05" }}
    assert_redirected_to experiment_url(@experiment)
  end

end
