class NotificationMailer < ApplicationMailer

  def application_pending_email(supervisor, application)
    @user = supervisor
    @app = application
    mail(to: @user.email, subject: "New Application Pending Your Approval")
  end

  def application_faculty_pending_email(requester, application)
    @user = requester
    @app = application
    mail(to: @user.email, subject: "Your Application is Pending Faculty Approval")
  end

  def application_refused_email(requester, application)
    @user = requester
    @app = application
    mail(to: @user.email, subject: "Your Application has been refused")
  end

  def application_change_email(requester, application)
    @user = requester
    @app = application
    mail(to: @user.email, subject: "Modifications have been requested on your Application")
  end
end
