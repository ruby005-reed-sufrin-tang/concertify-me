class UserMailer < ActionMailer::Base
  default from: "concertify.me@gmail.com"

  def example_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your Concertify Calendar Invite')
  end

end
