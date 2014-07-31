class AddFacebookRsvpUrlToEvent < ActiveRecord::Migration
  def change
    add_column :events, :facebook_rsvp_url, :string
  end
end
