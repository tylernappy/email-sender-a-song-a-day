class SendEmail < ActiveRecord::Base
  def self.send_scheduled(time_of_day)
    send_emails = SendEmail.where(when_to_send: time_of_day)
    send_emails.each do |send_email|
      email_addresses = send_email[:email_addresses].split("\r\n")
      Mailjet::MessageDelivery.create(
        to: email_addresses,
        from: ENV['myRegisteredMailjetEmailAtDomainDotCom'],
        subject: "Today's song is...",
        html:  "<p>Hi,</p>\n\n<p>Here's your song of the day, curated by <a href='#{send_email[:twitter_page]}' target='_blank'>#{send_email[:curator]}</a>:</p>\n\n<h2><a href='#{send_email[:link]}' target='_blank'>#{send_email[:song]} by #{send_email[:band]}</a></h2>\n\n<h3><a href='#{send_email[:click_to_tweet]}' target='_blank'>Tweet</a></h3>\n\n<p>#{send_email[:message]}</p>\n\n<p>Let me know what you think of the song. Happy listening!</p>"
      )
    end
    #deletes them from it all
    send_emails.delete_all
  end
end
