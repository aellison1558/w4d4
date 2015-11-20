class Activation < ApplicationMailer
  default from: 'music@musicapp.com'

  def activation_email(user, url)
    @user = user
    @url = url
    mail(to: user.email, subject: "Activation Link for MusicApp")
  end
end
