require 'test_helper'

class TripInvitesControllerTest < ActionController::TestCase
  setup do
    @trip_invite = trip_invites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trip_invites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip_invite" do
    assert_difference('TripInvite.count') do
      post :create, trip_invite: { accepted: @trip_invite.accepted, receiver: @trip_invite.receiver, sender: @trip_invite.sender, trip: @trip_invite.trip }
    end

    assert_redirected_to trip_invite_path(assigns(:trip_invite))
  end

  test "should show trip_invite" do
    get :show, id: @trip_invite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trip_invite
    assert_response :success
  end

  test "should update trip_invite" do
    put :update, id: @trip_invite, trip_invite: { accepted: @trip_invite.accepted, receiver: @trip_invite.receiver, sender: @trip_invite.sender, trip: @trip_invite.trip }
    assert_redirected_to trip_invite_path(assigns(:trip_invite))
  end

  test "should destroy trip_invite" do
    assert_difference('TripInvite.count', -1) do
      delete :destroy, id: @trip_invite
    end

    assert_redirected_to trip_invites_path
  end
end
