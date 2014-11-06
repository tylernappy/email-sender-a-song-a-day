class CreateSendEmails < ActiveRecord::Migration
  def change
    create_table :send_emails do |t|
      t.string :email_addresses
      t.string :link
      t.string :song
      t.string :band
      t.string :curator
      t.string :click_to_tweet
      t.string :message

      t.timestamps
    end
  end
end
