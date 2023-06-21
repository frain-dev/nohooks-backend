class AddPortalLinkToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :portal_link_url, :string
  end
end
