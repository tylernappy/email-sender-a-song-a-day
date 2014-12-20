class AddSchedulingFeature < ActiveRecord::Migration
  def change
    add_column :send_emails, :when_to_send, :string
  end
end
