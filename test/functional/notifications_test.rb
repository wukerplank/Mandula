require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "success" do
    mail = Notifications.success
    assert_equal "Success", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "error" do
    mail = Notifications.error
    assert_equal "Error", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
