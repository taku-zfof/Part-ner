# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Part-ner<#{ENV['MAILER_ADDRESS']}>"
  layout "mailer"
end
