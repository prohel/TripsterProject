require 'test_helper'

class AttachmentCommentsControllerTest < ActionController::TestCase
  setup do
    @attachment_comment = attachment_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attachment_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attachment_comment" do
    assert_difference('AttachmentComment.count') do
      post :create, attachment_comment: { description: @attachment_comment.description }
    end

    assert_redirected_to attachment_comment_path(assigns(:attachment_comment))
  end

  test "should show attachment_comment" do
    get :show, id: @attachment_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attachment_comment
    assert_response :success
  end

  test "should update attachment_comment" do
    put :update, id: @attachment_comment, attachment_comment: { description: @attachment_comment.description }
    assert_redirected_to attachment_comment_path(assigns(:attachment_comment))
  end

  test "should destroy attachment_comment" do
    assert_difference('AttachmentComment.count', -1) do
      delete :destroy, id: @attachment_comment
    end

    assert_redirected_to attachment_comments_path
  end
end
