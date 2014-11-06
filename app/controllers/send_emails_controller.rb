class SendEmailsController < ApplicationController
  def create_email
     @email = SendEmail.new
  end

  def send_email
     email_addresses = params[:send_email][:email_addresses].split("\r\n")
     debugger
     debugger
     email_addresses.each do |email_address|
        response = HTTParty.post(
            "https://api.mailjet.com/v3/send/message",
            :body => {
               :to => email_address,
               :from => ENV['myRegisteredMailjetEmailAtDomainDotCom'],
               :subject => "Today's song is...",
               :html => "#{params[:send_email][:link]}"
               # :subject => EmailTemplate.first.subject,
               # :html => EmailTemplate.first.body
            },
            :basic_auth => {:username => ENV['yourApiKey'], :password => ENV['yourSecretKey'] }
         )
         debugger
         debugger
         puts response
     end
   #   Mailjet::MessageDelivery.create(
   #    from: @email[:from],
   #    to: @email[:to],
   #    subject: @email[:subject],
   #    html: @email[:body],
   #    attachment: @email[:attachment]
   #   )
  end
end
