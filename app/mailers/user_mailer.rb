class UserMailer < ActionMailer::Base
  default from: "concertify.me@gmail.com"

  def example_email(user, event)
    @event = event
    @user = user
    @url  = 'concertify.me'
    #WE MUST REMEMBER TO TAKE THIS OUT
    if @user.email == "" || @user.email == nil
      @user.email = "ilanasufrin@gmail.com"
    end
    mail(to: @user.email, subject: @event.title)
  end

  def event_email(user, event)
    @user = user
    @event = event
    @url  = 'concertify.me'
    mail(to: @user.email, subject: "@event.title")
  end

end
