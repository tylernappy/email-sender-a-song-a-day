class UnsubscribeController < ApplicationController
  def create
     @email = Unsubscribe.new
  end

  def thanks
     @email = params[:unsubscribe][:email]
     Mailjet::MessageDelivery.create(
      to: ENV['myRegisteredMailjetEmailAtDomainDotCom'],
      from: ENV['myRegisteredMailjetEmailAtDomainDotCom'],
      subject: "#{@email} unsubscribed",
      text: "#{@email} unsubscribed.  Please remove them from the Google doc."
     )
  end
end
