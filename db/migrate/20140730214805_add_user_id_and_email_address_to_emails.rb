class AddUserIdAndEmailAddressToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :user_id, :integer
    add_column :emails, :email_address, :string
  end
end
