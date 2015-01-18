class SendEmailsController < ApplicationController
  def scheduled
     @morning_emails = SendEmail.where(when_to_send: "Morning")
     @evening_emails = SendEmail.where(when_to_send: "Evening")
  end

  def unschedule
     SendEmail.delete(params[:id])
     redirect_to send_emails_scheduled_path
  end

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
                 :html =>
"<!DOCTYPE HTML>
<html lang=\"en\"><head><meta content=\"text/html; charset=utf-8\" http-equiv=\"Content-Type\"><title>Your Song For Today</title><link rel=\"image_src\" href=\"http://22ht.mjt.lu/nlt/22ht/m.png\"><style type=\"text/css\">
 a { border: none; }
 img { border: none; }
 p { margin: 0; line-height: 1.3em; }
 #footer-msg a { color: #F3A836; }
 h1,h2,h3,h4,h5,h6 {font-size:100%;margin:0;}
 </style></head><body style=\"margin: 0; padding: 0; background-color: #eeeeee\" bgcolor=\"#eeeeee\">

 <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" align=\"center\" width=\"100%\"><tr><td align=\"center\" style=\"padding: 37px 0; background-color: #eeeeee;\" bgcolor=\"#eeeeee\">
 <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"600\"><tr><td style=\"vertical-align: top; text-align: left;\"><a href=\"http://22ht.mjt.lu/nl/22ht/m.html?[[UNSUB_PARAMS]]\" style=\"line-height: 1;vertical-align: top;color: #000000; font-family: arial; font-size: 11px; ;border: none;\">View online version</a></td>
 <td style=\"vertical-align: top; width: 400px; text-align: right; padding: 0 0 10px; color: #000000; font-family: arial; font-size: 11px; ; color: #444444; \"> Hand-curated with love.</td>
 </tr></table><!-- #nl_container --><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"margin: 0; border: 1px solid #dddddd; color: #444444; font-family: arial; font-size: 12px; border-color: #dddddd; background-color: #ffffff; \" width=\"600\"><tr><td>

 <!-- #nl_header -->
 <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" width=\"100%\"><tr><td>
 <a href=\"http://www.asongaday.co/\" style=\"border: none; display: block;border: none;\"><img width=\"600\" alt=\"\" style=\"display: block; width: 600px;border: none;\" src=\"http://22ht.mjt.lu/img/22ht/x/m.jpg\"></a>
 </td>
 </tr></table><!-- #nl_content --><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"margin: 0; border-collapse: collapse;\" width=\"100%\"><tr><td style=\"color: #444444; font-family: arial; font-size: 12px; border-color: #dddddd; background-color: #ffffff; padding: 5px 0;\" align=\"left\"><table style=\"margin: 0 0 0 10px;border-collapse:collapse;color: #444444; font-family: arial; font-size: 12px; border-color: #dddddd; background-color: #ffffff; \"><tr><td width=\"580\" style=\"vertical-align: top; padding: 5px 0; \"><table cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse:collapse;width:565px;color: #444444; font-family: arial; font-size: 12px; border-color: #dddddd; background-color: #ffffff; \" width=\"565\"><tr><td style=\"padding:5px 0 5px 5px;line-height:normal;color: #444444; font-family: arial; font-size: 12px; border-color: #dddddd; background-color: #ffffff; \"><p dir=\"ltr\" style=\"line-height:1.15;margin-top:0pt;margin-bottom:0pt;margin: 0 0 10px;line-height: 1.3em;\"><span id=\"docs-internal-guid-3b587608-4eae-b05d-a174-5802a413c6a3\">Hey there,<br><br></span>Here's your song of the day, curated by <a href='#{params[:send_email][:twitter_page]}' target='_blank'>#{params[:send_email][:curator]}</a>:<br><br></p><h2><a href='#{params[:send_email][:link]}' target='_blank'>#{params[:send_email][:song]} by #{params[:send_email][:band]}</a></h2><h3><a href='#{params[:send_email][:click_to_tweet]}' target='_blank'>Tweet</a></h3><p>#{params[:send_email][:message]}</p><p dir=\"ltr\" style=\"line-height:1.15;margin-top:0pt;margin-bottom:0pt;margin: 0 0 10px;line-height: 1.3em;\"><br></p><p dir=\"ltr\" style=\"line-height:1.15;margin-top:0pt;margin-bottom:0pt;margin: 0 0 10px;line-height: 1.3em;\">Hit reply and let me know what you think. <br><br><span id=\"docs-internal-guid-3b587608-4eae-b05d-a174-5802a413c6a3\">Happy listening!</span><br><span id=\"docs-internal-guid-3b587608-4eae-b05d-a174-5802a413c6a3\">Shannon</span><br><span id=\"docs-internal-guid-3b587608-4eae-b05d-a174-5802a413c6a3\"><a href=\"https://twitter.com/ShannnonB\" style=\"color: #0033cc; ;border: none;\">@ShannnonB</a></span><br><span id=\"docs-internal-guid-3b587608-4eae-b05d-a174-5802a413c6a3\"><a href=\"http://www.asongaday.co/\" style=\"color: #0033cc; ;border: none;\">aSongaDay.co</a></span><br></p></td></tr></table></td></tr></table></td>
 </tr></table></td>
 </tr></table><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" height=\"10\" style=\"height: 10px;border-collapse: collapse;font-size: 1px;\"><tr><td height=\"10\" style=\"height:10px; border-spacing: 0;font-size: 1px;\"> </td></tr></table><table cellpadding=\"10\" cellspacing=\"0\" border=\"0\" style=\"margin: 0; border-collapse: collapse;\" width=\"600\"><tr><td style=\"color: #444444; background-color: #eeeeee; border-color: #eeeeee; align: left; font-family: arial; font-size: 11px; \">
 <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width: 100%; margin: 0; border-collapse: collapse;\" width=\"100%\"><tr><td align=\"left\" valign=\"top\" style=\"vertical-align: top; text-align: left; color: #444444; background-color: #eeeeee; border-color: #eeeeee; align: left; font-family: arial; font-size: 11px; \">
 <div id=\"nl_footer\" style=\"display: block; text-align: left; margin: 0;\">This email has been sent to <a href=\"mailto:[[EMAIL_TO]]\" style=\"color:#000000;border: none;\">[[EMAIL_TO]]</a>, <a href=\"https://email-sender-a-song-a-day.herokuapp.com/unsubscribe/create\" style=\"color:#000000;border: none;\">click here to unsubscribe</a>.</div>
 <div id=\"footer_address\" style=\"display: block; text-align: left; margin: 5px 0 0;\">A Song A Day<br>
Shannon Byrne<br>
471 Vanderbilt Ave., Apt. 1E<br>
11238 Brooklyn<br></div>
 </td>
 <td align=\"right\" valign=\"top\" style=\"vertical-align: top; text-align: right\">
 <a href=\"http://www.mailjet.com\" style=\"border: none;border: none;\"><img class=\"nl_footer_logo\" alt=\"\" style=\"border: none;\" src=\"http://www.mailjet.com/images/theme/v1/logos/nl_logo_new.png\"></a>
 </td>

 </tr></table></td>
 </tr></table></td>
 </tr></table></body></html>"

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
