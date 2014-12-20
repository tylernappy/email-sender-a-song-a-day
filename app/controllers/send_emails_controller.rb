class SendEmailsController < ApplicationController
  def create_email
     @email = SendEmail.new
  end

  def send_email
     @email_addresses = params[:send_email][:email_addresses].split("\r\n")
     #if selected to send now
    #  debugger
    #  debugger
     if params[:send_email][:when_to_send] == "Now"
       @email_addresses.each do |email_address|
          response = HTTParty.post(
              "https://api.mailjet.com/v3/send/message",
              :body => {
                 :to => email_address,
                 :from => "Shannon from A Song A Day <#{ENV['myRegisteredMailjetEmailAtDomainDotCom']}>",
                 :subject => "Today's song is...",
                 :html => "<p>Hi,</p>\n\n
                 <p>Here's your song of the day, curated by <a href='#{params[:send_email][:twitter_page]}' target='_blank'>#{params[:send_email][:curator]}</a>:</p>\n\n
                 <h2><a href='#{params[:send_email][:link]}' target='_blank'>#{params[:send_email][:song]} by #{params[:send_email][:band]}</a></h2>\n\n
                 <h3><a href='#{params[:send_email][:click_to_tweet]}' target='_blank'>Tweet</a></h3>\n\n
                 <p>#{params[:send_email][:message]}</p>\n\n
                 <p>Let me know what you think of the song. Happy listening!</p>"
                 # :subject => EmailTemplate.first.subject,
                 # :html => EmailTemplate.first.body
              },
              :basic_auth => {:username => ENV['yourApiKey'], :password => ENV['yourSecretKey'] }
           )
           puts response
       end
     #if selected to schedule
     else
       SendEmail.create(send_email_params)
     end
   #   Mailjet::MessageDelivery.create(
   #    from: @email[:from],
   #    to: @email[:to],
   #    subject: @email[:subject],
   #    html: @email[:body],
   #    attachment: @email[:attachment]
   #   )
  end

  private
  def send_email_params
    params.require(:send_email).permit(:email_addresses, :link, :song, :band, :curator, :click_to_tweet, :message, :twitter_page, :when_to_send)
  end

end
