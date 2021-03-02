# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@todogether.projects.multimediatechnology.at'
  layout 'mailer'
end
