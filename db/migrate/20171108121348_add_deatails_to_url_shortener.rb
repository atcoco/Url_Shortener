class AddDeatailsToUrlShortener < ActiveRecord::Migration[5.1]
  def change
    add_column :url_shorteners, :prefix, :string
    add_column :url_shorteners, :main_domain, :string
    add_column :url_shorteners, :url, :string
    add_column :url_shorteners, :temp_url, :string
  end
end
