class UserMailer < ActionMailer::Base
  default from: "sky@onlinefilmrental.co.uk"

  def welcome_email
    @url  = "http://www.onlinefilmrental.co.uk"
    mail(:to => :from, :subject => "Newsletter")
  end
end
