class Notifications < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.success.subject
  #
  def success(video, user)
    @video = video
    @user  = user
    mail :to => @user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.error.subject
  #
  def error(video, user)
    @video = video
    @user  = user
    mail :to => @user.email
  end
end
