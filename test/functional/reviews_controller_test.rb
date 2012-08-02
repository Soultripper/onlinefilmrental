require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  test "should get lovefilm" do
    get :lovefilm
    assert_response :success
  end

  test "should get blockbuster" do
    get :blockbuster
    assert_response :success
  end

  test "should get netflix" do
    get :netflix
    assert_response :success
  end

  test "should get cinemaparadiso" do
    get :cinemaparadiso
    assert_response :success
  end

end
