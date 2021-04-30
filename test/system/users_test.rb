require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  setup do
    @user = users(:one)
  end

  test "sending a follow request to a user" do
    sign_in @user
    bob = users(:bob)

    visit user_url(bob.username)
  
    click_on "Follow"
    assert_selector "div", text: "Un-request"
  end

  test "accepting a follow request from a user" do
    sign_in @user
    bob = users(:bob)
    follow_requests(:bob_sent_request_to_one)

    visit user_url(bob.username)
  
    click_on "Accept follow request"
    assert_selector "div", text: "Follow request was successfully updated."
  end

  test "rejecting a follow request from a user" do
    sign_in @user
    bob = users(:bob)
    follow_requests(:bob_sent_request_to_one)

    visit user_url(bob.username)
  
    click_on "Reject follow request"
    assert_selector "div", text: "Follow request was successfully updated."
  end

  test "commenting on a photo in your feed" do
    @photo = photos(:alice)
    follow_requests(:one_follows_alice)
    sign_in @user
    visit root_url
  
    assert_selector "p", text: "Alice is the best."
    new_comment = "One commented"

    fill_in "Body", with: new_comment
    click_on "Create Comment"
    assert_selector "p", text: new_comment
  end


end
